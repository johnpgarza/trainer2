# Generated by Django 2.2 on 2020-03-10 04:23

from django.db import migrations
import phonenumber_field.modelfields


class Migration(migrations.Migration):

    dependencies = [
        ('clients', '0011_auto_20200309_2315'),
    ]

    operations = [
        migrations.AlterField(
            model_name='client',
            name='cell_phone',
            field=phonenumber_field.modelfields.PhoneNumberField(blank=True, max_length=128, region=None),
        ),
    ]
