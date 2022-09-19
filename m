Message-ID: <b66df962-e5ba-0862-86e8-0e934eee8dfc@...2181...>
Date: Mon, 19 Sep 2022 21:23:14 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220917140818.6155-1-a@...2181...>
 <CAKuzo_ihm3qrRXE6z=A3hz4bGzmaWpK11pjf_WqHGORQEfsP=A@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_ihm3qrRXE6z=A3hz4bGzmaWpK11pjf_WqHGORQEfsP=A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add common_name to the conv method.
 This allows the common_name to be accessible in PAM.
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
Cc: Michael Karvan <Michael.Karvan@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 18/09/2022 20:30, Selva Nair wrote:
> 
> 
> On Sat, Sep 17, 2022 at 10:09 AM Antonio Quartulli <a@...2181... 
> <mailto:a@...2181...>> wrote:
> 
>     From: Michael Karvan <Michael.Karvan@...277...
>     <mailto:Michael.Karvan@...277...>>
> 
>     Signed-off-by: Michael Karvan <Michael.Karvan@...277...
>     <mailto:Michael.Karvan@...277...>>
>     ---
>       src/plugins/auth-pam/auth-pam.c | 9 ++++++++-
>       1 file changed, 8 insertions(+), 1 deletion(-)
> 
>     diff --git a/src/plugins/auth-pam/auth-pam.c
>     b/src/plugins/auth-pam/auth-pam.c
>     index 70339445..9f37c8c0 100644
>     --- a/src/plugins/auth-pam/auth-pam.c
>     +++ b/src/plugins/auth-pam/auth-pam.c
>     @@ -746,8 +746,15 @@ my_conv(int n, const struct pam_message
>     **msg_array,
>                           }
>                           break;
> 
>     -                case PAM_ERROR_MSG:
>                       case PAM_TEXT_INFO:
>     +                    aresp[i].resp = strdup(up->common_name);
>     +                    if (aresp[i].resp == NULL)
>     +                    {
>     +                        ret = PAM_CONV_ERR;
>     +                    }
>     +                    break;
>     +
>     +                case PAM_ERROR_MSG:
>                           break;
> 
> 
> To add to what Gert's comment, we already support COMMONNAME in addition 
> to USERNAME, PASSWORD and
> OTP via text replacements for pam prompts specified in the config file. 
> Like:
> 
>   plugin openvpn-auth-pam.so "openvpn user USERNAME password PASSWORD cn 
> COMMONNAME"
> 
> and have the PAM module prompt for "user', "password" and "cn", for example.
> 
> So why do we need this non-standard stuff ?

Right. This means that this patch is *obsolete*, as we already have a 
way to convey the common name.

> 
> In fact, IMO, we should be getting rid of this whole "else {}" clause 
> starting line 728 that tries to guess the prompts based on echo-off ( to 
> mean password) echo-on (to mean username) etc. Instead, require that the 
> plugin line in the config file must specify expected prompts and 
> replacement strings as above.

Agreed. If we have a "clean" way to gather those details, we should get 
rid of the hack.

Cheers,


-- 
Antonio Quartulli

