Message-ID: <53166223.3020704@...1147...>
Date: Wed, 05 Mar 2014 00:30:43 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <5302AADC.80801@...277...>
	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>	<5304AFE4.2050702@...277...>
	<530917A4.4050905@...1528...>	<53093043.9080808@...277...>
	<5309B31C.50208@...1856...>	<530A9219.8050809@...277...>	<530BE62F.4090709@...1856...>
	<530E48C2.5090209@...277...>	<530E5529.9080204@...1856...>
	<53164A63.8020209@...277...>
	<CAA1AbxJC3_z5RvAkcRNhyy9m=OBheDDQ=8LVw18SwsS2QV4H6g@...278...>
In-Reply-To: <CAA1AbxJC3_z5RvAkcRNhyy9m=OBheDDQ=8LVw18SwsS2QV4H6g@...278...>
Content-Type: multipart/alternative;
	boundary="------------080308090900020005030805"
Subject: Re: [Openvpn-devel] [Patch] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, pietrek -- <pietrek.j@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080308090900020005030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/14 23:48, Steffan Karger wrote:
> Hi,
>
> On Tue, Mar 4, 2014 at 10:49 PM, pietrek -- <pietrek.j@...277... 
> <mailto:pietrek.j@...277...>> wrote:
>
>     [...]
>
>     I think we could add option "--dh none"  or "--no-dh". It may be
>     specified, if user knows what he's doing.
>
>
> I like that idea. It offers a migration path for users that really 
> want to skip the DH-stuff. I'd vote for "--dh '[none]'", as it does 
> not add a new option (openvpn has more then enough options ;) ), and 
> is hard to accidentally supply as a file name.
>
> This is more a usability thing then a crypto thing, so I'd like to 
> hear more opinions on this.
>
>     Option --no-ecdh( or --ecdh none ) could be useful if user does
>     not want
>     to use ECDH for some reason.
>
>
> I do not like this one. A user gets ECDH initialisation for free, and 
> if a power user really wants to disable ECDH, (s)he can use 
> --tls-cipher "DEFAULT:!EXP:!ECDH" or something like that. An explicit 
> extra option adds code, while it is not needed for the functionality.
>
>     Also, to avoid unexpected behaviour like fallback into RSA, we could
>     force openssl to use DH or ECDH only.
>
>
> Do you have any idea on how to achieve this, other than setting 
> explicit tls-cipher lists? The cipher list has a limited interface, 
> which would result in actively maintaining a list of 'approved' 
> ciphers within the OpenVPN codebase. I would not like to do that.
>
According to 'man SSL_CTX_set_tmp_rsa_callback'

        On OpenSSL servers ephemeral RSA key exchange is therefore 
disabled by default and must be explicitly
        enabled  using the SSL_OP_EPHEMERAL_RSA option of 
SSL_CTX_set_options(3), violating the TLS/SSL
        standard. When ephemeral RSA key exchange is required for export 
ciphers, it will automatically be
        used without this option!

so this would suggest that ephemeral RSA keys are not used by default 
unless explicitly enabled (as it breaks TLS/SSL).

cheers,

JJK




--------------080308090900020005030805
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 04/03/14 23:48, Steffan Karger
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAA1AbxJC3_z5RvAkcRNhyy9m=OBheDDQ=8LVw18SwsS2QV4H6g@...278..."
      type="cite">
      <div dir="ltr">Hi,<br>
        <div>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Tue, Mar 4, 2014 at 10:49 PM,
              pietrek -- <span dir="ltr">&lt;<a moz-do-not-send="true"
                  href="mailto:pietrek.j@...277..." target="_blank">pietrek.j@...277...</a>&gt;</span>
              wrote:<br>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">[...]</blockquote>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                I think we could add option "--dh none" &nbsp;or "--no-dh".
                It may be<br>
                specified, if user knows what he's doing.<br>
              </blockquote>
              <div><br>
              </div>
              <div>I like that idea. It offers a migration path for
                users that really want to skip the DH-stuff. I'd vote
                for "--dh '[none]'", as it does not add a new option
                (openvpn has more then enough options ;) ), and is hard
                to accidentally supply as a file name.<br>
                <br>
                This is more a usability thing then a crypto thing, so
                I'd like to hear more opinions on this.<br>
              </div>
              <div>&nbsp;</div>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                Option --no-ecdh( or --ecdh none ) could be useful if
                user does not want<br>
                to use ECDH for some reason.<br>
              </blockquote>
              <div><br>
              </div>
              <div>I do not like this one. A user gets ECDH
                initialisation for free, and if a power user really
                wants to disable ECDH, (s)he can use --tls-cipher
                "DEFAULT:!EXP:!ECDH" or something like that. An explicit
                extra option adds code, while it is not needed for the
                functionality.<br>
              </div>
              <div>&nbsp;</div>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                Also, to avoid unexpected behaviour like fallback into
                RSA, we could<br>
                force openssl to use DH or ECDH only.<br>
              </blockquote>
              <div><br>
              </div>
              <div>Do you have any idea on how to achieve this, other
                than setting explicit tls-cipher lists? The cipher list
                has a limited interface, which would result in actively
                maintaining a list of 'approved' ciphers within the
                OpenVPN codebase. I would not like to do that.<br>
                <br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    According to 'man SSL_CTX_set_tmp_rsa_callback'<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On OpenSSL servers ephemeral RSA key exchange is therefore
    disabled by default and must be explicitly<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled&nbsp; using the SSL_OP_EPHEMERAL_RSA option of
    SSL_CTX_set_options(3), violating the TLS/SSL<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; standard. When ephemeral RSA key exchange is required for
    export ciphers, it will automatically be<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used without this option!<br>
    <br>
    so this would suggest that ephemeral RSA keys are not used by
    default unless explicitly enabled (as it breaks TLS/SSL).<br>
    <br>
    cheers,<br>
    <br>
    JJK<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------080308090900020005030805--

