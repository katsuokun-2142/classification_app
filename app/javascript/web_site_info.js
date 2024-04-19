function web_site_info (){
  //リクエストを送信する処理
  // console.log("イベント発火");
  const deleteButtons = document.querySelectorAll('.delete-button');
  deleteButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      const webSiteInfoId = this.dataset.webSiteInfoId;
      const webSiteInfoElement = document.getElementById(`webSiteInfo_${webSiteInfoId}`);
      // Fetch APIを使用してサーバーに削除リクエストを送信
      fetch(`/web_site_infos/${webSiteInfoId}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        credentials: 'include'
      })
      .then(response => {
        if (response.ok) {
          // 削除が成功した場合、要素をDOMから削除
          webSiteInfoElement.remove();
          const remainingItems = document.querySelectorAll('.delete-button'); // .delete-buttonは各アイテムにつけられたクラス
          if (remainingItems.length === 0) {
            // アイテムが0になったら、前のページに移動
            const currentPageNumber = parseInt(new URLSearchParams(window.location.search).get('page'), 10);
            if (currentPageNumber && currentPageNumber > 1) {
              const previousPageNumber = currentPageNumber - 1;
              window.location.search = `?page=${previousPageNumber}`;
            }
            if (currentPageNumber <= 1) {
              window.location.search = '?page=1';
            }
          }
        } else {
          alert('Something went wrong.');
        }
      })
      .catch(error => console.error('Error:', error));
    });
  });
 };
 
 window.addEventListener('turbo:load', web_site_info);