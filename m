References: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
	<1465656195-12722-1-git-send-email-arne@...1227...>
	<20160611181434.GT62247@...1296...>
	<CAKuzo_gJLLjMWM7RRP=QzHBAEA6==f1BhEEa8gjL2W_FcGN-5A@...278...>
	<20160611202621.GU62247@...1296...>
	<CAKuzo_iFqH_uoAPKCL3GtHv9SE9P0Hn6BYyjmc_g9t3VL-C2ZQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8dce42be-d9df-69cb-52a6-1a3217697282@...1227...>
Date: Thu, 16 Jun 2016 11:33:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iFqH_uoAPKCL3GtHv9SE9P0Hn6BYyjmc_g9t3VL-C2ZQ@...278...>
Content-Type: multipart/alternative;
	boundary="------------8DD715B1EEF0A98000658CE2"
Subject: Re: [Openvpn-devel] [[PATCH v3]] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------8DD715B1EEF0A98000658CE2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


>  
>
>
>     I do wonder how useful these settings are, and why they are not
>     default...
>     they predate my OpenVPN involvement by many years.
>
>
> No clue..
I would just propose to remove the option (but accept configs with it in
it). Connecting logic with dualstack and new timeouts has changed enough
that this corner case behaviour isn't probably worth keeping. The option
probably predates even the connection list.

Arne

--------------8DD715B1EEF0A98000658CE2
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <br>
    <blockquote
cite=3D"mid:CAKuzo_iFqH_uoAPKCL3GtHv9SE9P0Hn6BYyjmc_g9t3VL-C2ZQ@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div>=A0<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <br>
              I do wonder how useful these settings are, and why they
              are not default...<br>
              they predate my OpenVPN involvement by many years.</blockquot=
e>
          </div>
          <br>
        </div>
        <div class=3D"gmail_extra">No clue..<br>
        </div>
      </div>
    </blockquote>
    I would just propose to remove the option (but accept configs with
    it in it). Connecting logic with dualstack and new timeouts has
    changed enough that this corner case behaviour isn't probably worth
    keeping. The option probably predates even the connection list.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------8DD715B1EEF0A98000658CE2--

