<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import= "java.util.List
            , java.util.HashMap
            , com.cyberone.scourt.model.UserInfo
            , com.cyberone.scourt.utils.StringUtil"
    
%>

<%@ include file="../include/header.jsp"%>

<%
    @SuppressWarnings("unchecked")
    List<HashMap<String, Object>> newsList = (List<HashMap<String, Object>>)request.getAttribute("list");
    
    int nRows =  (Integer)request.getAttribute("rows");
    int nTotalRecord =  (Integer)request.getAttribute("record");
    int nTotalPage = (Integer)request.getAttribute("total");
    int nGroupPos = (Integer)request.getAttribute("group");
    int nGroupEndPos = (Integer)request.getAttribute("groupEnd");
    int nGroupStartPos = (Integer)request.getAttribute("groupStart");
    int nPrevPageNo = (Integer)request.getAttribute("prev");
    int nNextPageNo = (Integer)request.getAttribute("next");
    int nPage = (Integer)request.getAttribute("page");
    
    String sSearchWord = StringUtil.convertString(request.getParameter("searchWord"));
%>

<script type="text/javascript">

NEWS_LIST = (function() {

	return {
		   init: function() {
			   console.log('NEWS_LIST.init()');
		   }
	};
	
})();

$(document).ready(function() {

	NEWS_LIST.init();
    
});

function doSearch() {
    document.searchForm.submit();
}

</script>

<div class="board_pane" style="background-color:lightgray;font: 12px 맑은 고딕;padding: 10px 0px;">

    <h1 style="margin: 0px auto 10px auto;width: 200px;text-align: center;">보안뉴스</h1>

    <div style="text-align: right;">
    <form name="searchForm" action="/securityNews/" method="post">
	    <input name="page" type="hidden" value="1">
        <input name="searchWord" id="searchWord" type="text" style="width: 150px;" value="<%=sSearchWord%>"/>
        <a href="javascript:doSearch();">검색</a>
    </form>
    </div>
    
    <table cellpadding="0" cellspacing="0" border="1" style="width: 70%;margin: 0 auto;">
        <colgroup>
            <col width="5%">
            <col width="55%">
            <col width="25%">
            <col width="*">
        </colgroup>
        <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>출처</th>
              <th>등록일자</th>
            </tr>
         </thead>
        <tbody>
    <%  if (newsList.size() > 0) {
    	    int m = (nPage - 1) * nRows; 
            for (HashMap<String, Object> map : newsList) { %>
            <tr>
                <td><%=nTotalRecord - m++ %></td>
                <td style="font-weight: bold;"><a style="color: #3577c8;" href="<%=StringUtil.convertString(map.get("rssLink"))%>" target='_blank'><%=StringUtil.convertString(map.get("rssTit")) %></a></td>
                <td><%=StringUtil.convertString(map.get("rssSrc")) %></td>
                <td><%=StringUtil.convertDate(map.get("regDtime"), "yyyy-MM-dd") %></td>
            </tr>
    <%      }
        } else { %>
            <tr align="center">
                <td colspan="6">
                    <font color="tomato"><b>등록된 데이터가 없습니다!</b></font>
                </td>
            </tr>
    <% } %>
            
        </tbody>
    </table>

<% if (newsList.size() > 0) { %>
    <div style="margin: 5px auto 0px auto;text-align: center;">
        <a class="pre" href="/securityNews/?page=<%=nPrevPageNo%>&searchWord=<%=sSearchWord%>"><img src="/images/btn_page_prev.gif" width="16" height="16" alt="이전"></a>
<% for (int i=nGroupStartPos; i<=nGroupEndPos; i++) { %>
    <% if (nPage == i) { %>
        <strong><span><%=i %></span></strong>
    <% } else { %>
        <a href="/securityNews/?page=<%=i %>&searchWord=<%=sSearchWord%>"><span><%=i %></span></a>
    <% }  %>
<% } %>
        <a class="next" href="/securityNews/?page=<%=nNextPageNo%>&searchWord=<%=sSearchWord%>"><img src="/images/btn_page_next.gif" width="16" height="16" alt="다음"></a>
    </div>
<% } %>

    <div class="tableBtnBox">
        <a href="/securityNewsWrite?page=<%=nPage %>&searchWord=<%=sSearchWord%>">
            글쓰기
        </a>
    </div>

</div>
  


<%@ include file="../include/footer.jsp"%>