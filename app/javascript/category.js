// function handleDeleteCateGory(e) {
//   e.preventDefault();
//   let result = window.confirm('本当に削除してもよろしいですか？');
//   if (result) {
//     const categoryId = this.dataset.categoryId;
//     const webSiteInfoId = this.dataset.webSiteInfoId;
//     const webSiteInfoElement = document.getElementById(`webSiteInfo_${webSiteInfoId}`);
//     // Fetch APIを使用してサーバーに削除リクエストを送信
//     fetch(`/categories/${categoryId}/web_site_infos/${webSiteInfoId}`, {
//       method: 'DELETE',
//       headers: {
//         'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
//       },
//       credentials: 'include'
//     })
//     .then(response => {
//       if (response.ok) {
//         // 削除が成功した場合、要素をDOMから削除
//         webSiteInfoElement.remove();
//         const remainingItems = category.querySelectorAll('.category-delete-button'); // .delete-buttonは各アイテムにつけられたクラス
//         if (remainingItems.length === 0) {
//           // アコーディオンを削除する
//           // const categoryId = this.dataset.categoryId;
//           const categoryElement = document.getElementById(`category_${categoryId}`);
//           categoryElement.remove();
//           const remainingCategories = document.querySelectorAll('.accordion-category');
//           if (remainingCategories.length === 0) {
//             // アイテムが0になったら、前のページに移動
//             const currentPageNumber = parseInt(new URLSearchParams(window.location.search).get('page'), 10);
//             if (currentPageNumber && currentPageNumber > 1) {
//               const previousPageNumber = currentPageNumber - 1;
//               window.location.search = `?page=${previousPageNumber}`;
//             }
//             if (currentPageNumber <= 1) {
//               window.location.search = '?page=1';
//             }
//           }
//         }
//       } else {
//         alert('Something went wrong.');
//       }
//     })
//     .catch(error => console.error('Error:', error));
//   }
// };

function category (){
  //リクエストを送信する処理
  // console.log("イベント発火");
  const accordionCategories = document.querySelectorAll('.accordion-category');
  accordionCategories.forEach(category => {
    const deleteButtons = category.querySelectorAll('.category-delete-button');
    console.log(deleteButtons);
    deleteButtons.forEach(button => {
      button.addEventListener('click', function(e) {
        e.preventDefault();
        let result = window.confirm('本当に削除してもよろしいですか？');
        if (result) {
          const categoryId = this.dataset.categoryId;
          const webSiteInfoId = this.dataset.webSiteInfoId;
          const webSiteInfoElement = document.getElementById(`webSiteInfo_${webSiteInfoId}`);
          // Fetch APIを使用してサーバーに削除リクエストを送信
          fetch(`/categories/${categoryId}/web_site_infos/${webSiteInfoId}`, {
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
              const remainingItems = category.querySelectorAll('.category-delete-button'); // .delete-buttonは各アイテムにつけられたクラス
              if (remainingItems.length === 0) {
                // アコーディオンを削除する
                // const categoryId = this.dataset.categoryId;
                const categoryElement = document.getElementById(`category_${categoryId}`);
                categoryElement.remove();
                const remainingCategories = document.querySelectorAll('.accordion-category');
                if (remainingCategories.length === 0) {
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
              }
            } else {
              alert('Something went wrong.');
            }
          })
          .catch(error => console.error('Error:', error));
        }
      });
    });
  });
 };
 
 window.addEventListener('turbo:load', category);