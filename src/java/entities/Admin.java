/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 *
 * @author pc
 */
@Entity
@Table(name = "admin")
public class Admin extends User {

    public Admin() {
    }

    public Admin(String nom, String email, String motDePasse, String secretQuestion, String secretAnswer) {
        super(nom, email, motDePasse, secretQuestion, secretAnswer);
    }

}
