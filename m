MIME-Version: 1.0
References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
 <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
 <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
 <20190420150719.GM31008@...1296...>
 <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>
In-Reply-To: <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>
From: wei wang <lnykww@...277...>
Date: Tue, 23 Apr 2019 11:01:59 +0800
Message-ID: <CAPM6dUDJXL+Ncf3Fm2xW1rsf4ohYkzWMrhr8hJ9WraRQOtUHFw@...278...>
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: ???????? ?????????????? <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

3. clean client connect defered ret file when close instance.

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 27c6e935..7291d651 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -685,6 +685,9 @@ multi_close_instance(struct multi_context *m,
     set_cc_config(mi, NULL);
 #endif

+    // client connect deferred ret file delete
+    ccs_delete_deferred_ret_file(mi);
+
     multi_client_disconnect_script(m, mi);

     if (mi->did_open_context)
wei wang <lnykww@...277...> =E4=BA=8E2019=E5=B9=B44=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:26=E5=86=99=E9=81=93=EF=BC=9A
>
> 1. When client-connect tests whether the user has written the
> configuration, we should check to see if the file size is 0, not
> whether the file exists.
>     Because the configuration file is created by openvpn itself.
> 2. multi_client_connect_early_setup should be called for the first time.
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 697994b8..27c6e935 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1641,9 +1641,13 @@ multi_client_connect_post(struct multi_context *m,
>                            const char *dc_file,
>                            unsigned int *option_types_found)
>  {
> -    /* Did script generate a dynamic config file? */
> -    if (platform_test_file(dc_file))
> -    {
> +    /* Did script write config to dynamic config file? */
> +    platform_stat_t dc_stat =3D {0};
> +    if (platform_stat(dc_file, &dc_stat) < 0) {
> +        return;
> +    }
> +
> +    if (dc_stat.st_size > 0) {
>          options_server_import(&mi->context.options,
>                                dc_file,
>                                D_IMPORT_ERRORS|M_OPTERR,
> @@ -2474,13 +2478,13 @@ multi_connection_established(struct
> multi_context *m, struct multi_instance *mi)
>              /* Initially we have no handler that has returned a result */
>              mi->client_connect_status =3D CC_STATUS_DEFERRED_NO_RESULT;
>              from_deferred =3D false;
> +            multi_client_connect_early_setup(m, mi);
>          }
>          else
>          {
>              from_deferred =3D true;
>          }
>
> -        multi_client_connect_early_setup(m, mi);
>
>          bool cc_succeeded =3D true;
>
> Gert Doering <gert@...1296...> =E4=BA=8E2019=E5=B9=B44=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8811:07=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > On Sat, Apr 20, 2019 at 04:37:03PM +0800, wei wang wrote:
> > > I have found that the patch set
> > > "https://patchwork.openvpn.net/project/openvpn2/list/?series=3D413" h=
as
> > > implement it.
> > > But it has not been updated for several months. Is there someone still
> > > work on it?  We test with it for client-connect script, and find some
> > > bug.
> > > I am very happy to provide if needed.
> >
> > We're working on reviewing, fixing and merging it.
> >
> > So if you have feedback or even found a bug, please send it in (preferr=
ably
> > in reply to the original mail, so patchwork can pick it up, but just he=
re
> > in the thread is good enough).
> >
> > gert
> > --
> > "If was one thing all people took for granted, was conviction that if y=
ou
> >  feed honest figures into a computer, honest figures come out. Never do=
ubted
> >  it myself till I met a computer with a sense of humor."
> >                              Robert A. Heinlein, The Moon is a Harsh Mi=
stress
> >
> > Gert Doering - Munich, Germany                             gert@...1726...=
...
>
>
>
> --
> Regards,
> Wang Wei



--=20
Regards,
Wang Wei

