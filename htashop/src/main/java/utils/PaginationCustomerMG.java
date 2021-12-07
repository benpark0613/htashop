package utils;

public class PaginationCustomerMG {
	private int rowsPerPage = 10;
	private int pagesPerBlock = 5;
	private int page = 1;
	private int totalPages;
	private int totalBlocks;

	public PaginationCustomerMG(int page, int totalRows) {
		this.totalPages = (int)(Math.ceil((double)totalRows/rowsPerPage));
		if (totalPages == 0) {
			this.totalPages = 1;
		}
		this.totalBlocks = (int)(Math.ceil((double)totalPages/pagesPerBlock));
		this.page = page;
		if (page <= 0 || page > totalPages) {
			this.page = 1;
		}
	}

	public int getPage() {
		return page;
	}
	public int getCurrentBlock() {
		return (int)(Math.ceil((double)this.page/pagesPerBlock));
	}
	public int getTotalPages() {
		return totalPages;
	}
	public int getTotalBlocks() {
		return totalBlocks;
	}
	public int getBegin() {
		return (this.getCurrentBlock() - 1)*pagesPerBlock + 1;
	}
	public int getEnd() {
		return getCurrentBlock() < totalBlocks ? this.getCurrentBlock()*pagesPerBlock : totalPages;
	}
	public int getBeginIndex() {
		return (page - 1)*rowsPerPage + 1;
	}
	public int getEndIndex() {
		return page*rowsPerPage;
	}
	public boolean isExistPrev() { 
		return getCurrentBlock() > 1; 
	}
	public boolean isExistNext() { 
		return getCurrentBlock() < getTotalBlocks(); 
	}
	public int getPrev() {
		if (isExistPrev()) {
			return (getCurrentBlock() - 1)*pagesPerBlock;
		}
		return page;
	}
	public int getNext() {
		if (isExistNext()) {
			return getCurrentBlock()*pagesPerBlock + 1;
		}
		return page;
	}
}
