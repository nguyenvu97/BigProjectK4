package org.springframework.boot.ticket.dto;

import java.util.List;

public class PageDto extends PagingDto {
    @SuppressWarnings("rawtypes")
    public List content;
    public long totalElements;

    public int number;
    public int numberOfElements;
    public int totalPages;
}
