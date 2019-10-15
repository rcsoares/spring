package br.com.cni.safira.batch;

import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.FieldSet;

public class PersonFieldSetMapper implements FieldSetMapper<Person> {
    public Person mapFieldSet(FieldSet fieldSet) {
        Person Person = new Person();
        Person.setLastName(fieldSet.readString(0));
        Person.setFirstName(fieldSet.readString(1));
        return Person;
    }
}