Message-ID: <01a373b7-3a39-6d43-a398-ab5603d03ace@...2181...>
Date: Wed, 14 Sep 2022 21:30:51 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220914185937.31423-1-a@...2181...>
 <20220914185937.31423-2-a@...2181...>
 <CAKuzo_j_yNVkYW1mra2yPnOU3gWSjWSZKk7qkSk3Xjabmc=roA@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_j_yNVkYW1mra2yPnOU3gWSjWSZKk7qkSk3Xjabmc=roA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] get_user_pass_cr: get password from
 stdin if missing inline
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 14/09/2022 21:26, Selva Nair wrote:
>     diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>     index 07f6e202..50f7f975 100644
>     --- a/src/openvpn/misc.c
>     +++ b/src/openvpn/misc.c
>     @@ -197,6 +197,11 @@ get_user_pass_cr(struct user_pass *up,
>                       buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
>                   }
>                   buf_parse(&buf, '\n', up->password, USER_PASS_LEN);
>     +
>     +            if (strlen(up->password) == 0)
>     +            {
>     +                password_from_stdin = 1;
> 
> 
> This works when stdin is available, but reading username from file and 
> password from the management interface is still not possible. Currently, 
> if --management-query-passwords and --auth-user-pass are used, the file 
> must contain username and password (management i/f not queried). This 
> patch allows username only files, but only if reading from stdin is 
> possible.

Just to make sure I got your comment right: this patch is not allowing 
files to have no password (this is allowed already without this patch).
This patch is only allowing having no password when doing inline 
credentials.

Does your comment still apply?

If the mgmt interface has troubles with querying the password, then it 
means we already have this problem without the patch, right?


-- 
Antonio Quartulli

