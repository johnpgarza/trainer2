from django.contrib import admin
from .models import Client, ExerciseCategory, Exercises, Diary, Comment
from django.http import HttpResponse
import csv
import datetime


def export_to_csv(modeladmin, request, queryset):
    opts = modeladmin.model._meta
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment;' \
                                      'filename={}.csv'.format(opts.verbose_name)
    writer = csv.writer(response)

    fields = [field for field in opts.get_fields() if not field.many_to_many
              and not field.one_to_many]
    # Write a first row with header information
    writer.writerow([field.verbose_name for field in fields])
    # Write data rows
    for obj in queryset:
        data_row = []
        for field in fields:
            value = getattr(obj, field.name)
            if isinstance(value, datetime.datetime):
                value = value.strftime('%d/%m/%Y')
            data_row.append(value)
        writer.writerow(data_row)
    return response


export_to_csv.short_description = 'Export to CSV'


class ClientAdmin(admin.ModelAdmin):
    model = Client
    actions = [export_to_csv]


class ExerciseCategoryAdmin(admin.ModelAdmin):
    model = ExerciseCategory


class ExercisesAdmin(admin.ModelAdmin):
    model = Exercises
    actions = [export_to_csv]


class DiaryAdmin(admin.ModelAdmin):
    model = Diary
    actions = [export_to_csv]


class CommentAdmin(admin.ModelAdmin):
    model = Comment
    actions = [export_to_csv]


admin.site.register(Client, ClientAdmin)
admin.site.register(ExerciseCategory, ExerciseCategoryAdmin)
admin.site.register(Exercises, ExercisesAdmin)
admin.site.register(Diary, DiaryAdmin)
admin.site.register(Comment, CommentAdmin)
