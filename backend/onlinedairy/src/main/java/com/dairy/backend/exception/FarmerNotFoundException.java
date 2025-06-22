package com.dairy.backend.exception;
import com.dairy.backend.model.Farmer;
import lombok.Getter;

import java.util.List;

@Getter
public class FarmerNotFoundException extends RuntimeException {
    private  List<Farmer> availableFarmers;

    public FarmerNotFoundException(String message, List<Farmer> availableFarmers) {
        super(message);
        this.availableFarmers = availableFarmers;
    }

}