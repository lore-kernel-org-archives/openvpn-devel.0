MIME-Version: 1.0
References: <20221010071229.7935-1-gert@...1296...>
 <CAKuzo_jMWxigVoqxJNHdx+yfn2CBHamECs3Fq3QFsNpSJ9jK_g@...278...>
 <b6f32757-f446-6fad-85a5-def6422e6f16@...1227...>
In-Reply-To: <b6f32757-f446-6fad-85a5-def6422e6f16@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Oct 2022 11:01:34 -0400
Message-ID: <CAKuzo_iXwnh8v5RVrFgD+UcE814CsudD0DTYXMmkjjW61D9cUg@...278...>
Content-Type: multipart/alternative; boundary="000000000000df689f05eb6484fe"
Subject: Re: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--000000000000df689f05eb6484fe
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 19, 2022 at 1:05 AM Arne Schwabe <arne@...1227...> wrote:

>
>
> If we can conjure up usernames (like with empty --> token-user) why not
> allow other username
> changes too?
>
> In general the current authentication system in OpenVPN is ill equipped to
> handle them. On renegotiation we only do auth but no read in ccd or other
> other user specific data. So allowing a username change could in many
> instances give the new user the permissions/IP etc of the old user. There
> can be situations where this is okay and we can add options or auth results
> that explicitly allow. In general a username change probably leads
> authorisation problems. For the auth-token-user the idea there is that you
> get a username on the first auth assigned that you should use in the future
> but no actual user change.
>
That makes a lot of sense. Even I have setups where what is pushed to the
client depends on the username in addition to the commonname.

This has implications when we have interactively authenticated, but long
running connections which multiple users may be able to use though it will
appear to be associated with one user from the server's pov (so-called
Persistent connections in Windows GUI). Same with PLAP.  Requiring a new
tunnel on user name change alleviates this a bit, but still there will be a
duration until next reauth or token expiry when userA is using a tunnel
started by userB.  Instead of wading into an OT discussion, I will raise
this issue elsewhere / a new thread

Selva

--000000000000df689f05eb6484fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 19, 2022 at 1:05 AM Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div>
    <p><br></p><blockquote type=3D"cite"><div dir=3D"ltr"><div class=3D"gma=
il_quote">
          <div><br>
          </div>
          <div>If we can conjure up usernames (like with empty --&gt;
            token-user) why not allow other username</div>
          <div>changes=C2=A0too?</div>
        </div>
      </div>
    </blockquote>
    <p>In general the current authentication system in OpenVPN is ill
      equipped to handle them. On renegotiation we only do auth but no
      read in ccd or other other user specific data. So allowing a
      username change could in many instances give the new user the
      permissions/IP etc of the old user. There can be situations where
      this is okay and we can add options or auth results that
      explicitly allow. In general a username change probably leads
      authorisation problems. For the auth-token-user the idea there is
      that you get a username on the first auth assigned that you should
      use in the future but no actual user change.</p></div></blockquote><d=
iv>That makes a lot of sense. Even I have setups where what is pushed to th=
e client depends on the=C2=A0username in addition to the=C2=A0commonname.=
=C2=A0=C2=A0</div><div><br></div><div>This has implications when we have in=
teractively authenticated, but long running connections which multiple user=
s may be able to use though it will appear to be associated with one user f=
rom the server&#39;s pov (so-called Persistent connections in Windows GUI).=
 Same with PLAP.=C2=A0 Requiring a new tunnel on user name change alleviate=
s this a bit, but still there will be a duration until next reauth or token=
 expiry when userA is using a tunnel started by userB.=C2=A0 Instead of wad=
ing into an OT discussion, I will raise this issue elsewhere / a new thread=
</div><div><br></div><div>Selva</div></div></div>

--000000000000df689f05eb6484fe--

