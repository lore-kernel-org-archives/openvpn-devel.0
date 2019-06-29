MIME-Version: 1.0
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
 <20190629095732.GV1097@...1296...>
 <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
 <CAGyAFMX8247tuQB7eaKFJiOJS+tXOiu3eMv5RJU6ZZmkugjeNg@...278...>
In-Reply-To: <CAGyAFMX8247tuQB7eaKFJiOJS+tXOiu3eMv5RJU6ZZmkugjeNg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 29 Jun 2019 11:16:59 -0400
Message-ID: <CAKuzo_jot=WiQf6kEicoA9vT2_sL4P7xjK2DD0Ui49LUqeYpPw@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sat, Jun 29, 2019 at 10:50 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> That --allow-nonadmin functionality was included into commit 3c7f2f553 from yeah 2005. Here is code from tap-win32/tapdrv.c from the same commit:
>
> +#if ENABLE_NONADMIN
> +       /* Read AllowNonAdmin setting from registry */
> +       {
> +         NDIS_STRING key = NDIS_STRING_CONST("AllowNonAdmin");
> +         NdisReadConfiguration (&status, &parm, configHandle,
> +                                &key, NdisParameterInteger);
> +         if (status == NDIS_STATUS_SUCCESS)
> +           {
> +             if (parm->ParameterType == NdisParameterInteger)
> +               {
> +                 if (parm->ParameterData.IntegerData)
> +                   {
> +                       enable_non_admin = TRUE;
> +                   }
> +               }
> +           }
> +       }
> +#endif
>
> As you see, the current version posted by Selva is missing
>
>   if (parm->ParameterData.IntegerData)
>
> part.
>
> So it seems for me that this feature has been degraded somewhere between 2005 and 2019.

If the idea was to remove the feature, the whole code between those
#if-#endif could have been removed. The way it stands looks like a bug.

Anyway, our installer always sets the AllowNonAdmin key as true, so we will
not break any setups by "fixing" this.

Selva

