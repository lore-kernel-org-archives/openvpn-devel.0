Content-Type: multipart/alternative;
 boundary="------------tKi3agdnW0n8gGEt3wTVXsUI"
Message-ID: <b6f32757-f446-6fad-85a5-def6422e6f16@...1227...>
Date: Wed, 19 Oct 2022 07:05:55 +0200
MIME-Version: 1.0
References: <20221010071229.7935-1-gert@...1296...>
 <CAKuzo_jMWxigVoqxJNHdx+yfn2CBHamECs3Fq3QFsNpSJ9jK_g@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_jMWxigVoqxJNHdx+yfn2CBHamECs3Fq3QFsNpSJ9jK_g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------tKi3agdnW0n8gGEt3wTVXsUI
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


Am 19.10.2022 um 01:01 schrieb Selva Nair:
> Hi,
>
> On Mon, Oct 10, 2022 at 3:14 AM Gert Doering <gert@...1296...> wrote:
>
>     We do not permit username changes on renegotiation (= username is
>     "locked" after successful initial authentication).
>
>     Unfortunately the way this is written this gets in the way of using
>     auth-user-pass-optional + pushing "auth-token-user" from
>     client-connect
>     (and most likely also "from management") because we'll lock an empty
>     username, and on renegotiation, refuse the client with
>
>
> Why is it not okay to support change of username?. I have a situation
> where username change looks legitimate:
>
> With our new PLAP (start from login screen) and "persistent 
> connection" support on Windows,
> a connection may be started by one user and then "renegotiated" by 
> another who may enter
> a different username and password from the initial connection (say 
> auth-nocache or 2FA
> is in use).
>
> In this case, the server will disable the tunnel (username tried to 
> change), the client will retry
> asking the user for username/password input again. On inputting the 
> same credentials a
> second time, the connection will succeed. This leads to poor UX.
>
> If we can conjure up usernames (like with empty --> token-user) why 
> not allow other username
> changes too?

In general the current authentication system in OpenVPN is ill equipped 
to handle them. On renegotiation we only do auth but no read in ccd or 
other other user specific data. So allowing a username change could in 
many instances give the new user the permissions/IP etc of the old user. 
There can be situations where this is okay and we can add options or 
auth results that explicitly allow. In general a username change 
probably leads authorisation problems. For the auth-token-user the idea 
there is that you get a username on the first auth assigned that you 
should use in the future but no actual user change.

Arne

--------------tKi3agdnW0n8gGEt3wTVXsUI
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 19.10.2022 um 01:01 schrieb Selva
      Nair:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKuzo_jMWxigVoqxJNHdx+yfn2CBHamECs3Fq3QFsNpSJ9jK_g@...278...">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Hi,</div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Oct 10, 2022 at 3:14
            AM Gert Doering &lt;<a href="mailto:gert@...1296..."
              target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">gert@...1296...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">We do not permit username
            changes on renegotiation (= username is<br>
            "locked" after successful initial authentication).<br>
            <br>
            Unfortunately the way this is written this gets in the way
            of using<br>
            auth-user-pass-optional + pushing "auth-token-user" from
            client-connect<br>
            (and most likely also "from management") because we'll lock
            an empty<br>
            username, and on renegotiation, refuse the client with<br>
          </blockquote>
          <div><br>
          </div>
          <div>Why is it not okay to support change of username?. I have
            a situation</div>
          <div>where username change looks legitimate:</div>
          <div><br>
          </div>
          <div>With our new PLAP (start from login screen) and
            "persistent connection" support on Windows,</div>
          <div>a connection may be started by one user and then
            "renegotiated" by another who may enter</div>
          <div>a different username and password from the
            initial connection (say auth-nocache or 2FA</div>
          <div>is in use). </div>
          <div><br>
          </div>
          <div>In this case, the server will disable the tunnel
            (username tried to change), the client will retry</div>
          <div>asking the user for username/password input again. On
            inputting the same credentials a</div>
          <div>second time, the connection will succeed. This leads to
            poor UX.</div>
          <div><br>
          </div>
          <div>If we can conjure up usernames (like with empty --&gt;
            token-user) why not allow other username</div>
          <div>changes too?</div>
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
      use in the future but no actual user change.</p>
    <p>Arne<br>
    </p>
  </body>
</html>

--------------tKi3agdnW0n8gGEt3wTVXsUI--

