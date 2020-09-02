MIME-Version: 1.0
References: <20200902133755.308-1-lstipakov@...277...>
 <CAKuzo_hmoG=MfxsuefwJ5CUMHvXAYCH-n5A-DP4JsJsWBPr-qg@...278...>
In-Reply-To: <CAKuzo_hmoG=MfxsuefwJ5CUMHvXAYCH-n5A-DP4JsJsWBPr-qg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 2 Sep 2020 16:53:57 +0300
Message-ID: <CAGyAFMVpyJ2tgwopvArJrteJcPCF2bE80ezbGXVgotpJQBsBYQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: make adapter renaming
 non-fatal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

>>                  if (dwResult != ERROR_SUCCESS)
>>                  {
>> -                    tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
>> +                    /* failed renaming is not a fatal error, continue */
>> +                    dwResult = ERROR_SUCCESS;
>
>
> This looks strange. If we are going to rewrite dwResult, why set it and check it at all, just call
> tap_set_adapter() without storing the return value and add the comment.

I think this is good for documentation purposes - that we are aware
that function may fail, but in this case it is not fatal and we continue.

> Or, better, print a warning message saying the rename failed.

Warning is printed inside tap_delete_adapter().

-- 
-Lev

