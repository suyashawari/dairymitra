//package com.dairy.backend.repository;
//
//import com.dairy.backend.model.AppUser;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
//
//@Repository
//public interface AppUserRepository extends JpaRepository<AppUser, Long> {
//    AppUser findByUsername(String username);
//}
//

package com.dairy.backend.repository;

import com.dairy.backend.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    AppUser findByName(String name);

    AppUser findByEmail(String email);
}

