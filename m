Message-ID: <5548E90C.7040605@...1227...>
Date: Tue, 05 May 2015 18:00:12 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1430840857-6123-1-git-send-email-steffan@...1856...>
In-Reply-To: <1430840857-6123-1-git-send-email-steffan@...1856...>
Content-Type: multipart/alternative;
	boundary="------------050204040306030905040902"
Subject: Re: [Openvpn-devel] [PATCH] Improve --tls-cipher and --show-tls man
 page description
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050204040306030905040902
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 05.05.15 um 17:47 schrieb Steffan Karger:
> As reported in trac tickets #304, #358 and #359 (and possibly more), the
> usage and interpretation of --tls-cipher (and --show-tls) is tricky.  This
> patch extends the man page to explain those a bit better and point out
> that --tls-cipher is an expert feature (i.e. easy to get wrong).  Also add
> a notice to the --show-tls output, referring to the man page explanation.
>
ACK. Also note that even my app has a FAQ related to tls-cipher:

Newer OpenVPN for Android versions (0.6.29/March 2015) use a more secure
default for the allowed cipher suites (tls-cipher
\"DEFAULT:!EXP:!PSK:!SRP:!kRSA\"). Unfortunately, omitting the less
secure cipher suites and export cipher suites, especially the omission
of cipher suites that do not support Perfect Forward Secrecy
(Diffie-Hellman) causes some problems. This usually caused by an
well-intentioned but poorly executed attempts to strengthen TLS security
by setting tls-cipher on the server or some embedded OSes with stripped
down SSL (e.g. MikroTik).

To solve this problem the problem, set the tls-cipher settings on the
server to reasonable default like tls-cipher
\"DEFAULT:!EXP:!PSK:!SRP:!kRSA\". To work around the problem on the
client add the custom option tls-cipher DEFAULT on the Android client.

--------------050204040306030905040902
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">Am 05.05.15 um 17:47 schrieb Steffan
      Karger:<br>
    </div>
    <blockquote
      cite="mid:1430840857-6123-1-git-send-email-steffan@...1856..."
      type="cite">
      <pre wrap="">As reported in trac tickets #304, #358 and #359 (and possibly more), the
usage and interpretation of --tls-cipher (and --show-tls) is tricky.  This
patch extends the man page to explain those a bit better and point out
that --tls-cipher is an expert feature (i.e. easy to get wrong).  Also add
a notice to the --show-tls output, referring to the man page explanation.

</pre>
    </blockquote>
    ACK. Also note that even my app has a FAQ related to tls-cipher:<br>
    <br>
    <meta http-equiv="content-type" content="text/html;
      charset=windows-1252">
    Newer OpenVPN for Android versions (0.6.29/March 2015) use a more
    secure default for the allowed cipher suites (tls-cipher
    \"DEFAULT:!EXP:!PSK:!SRP:!kRSA\"). Unfortunately, omitting the less
    secure cipher suites and export cipher suites, especially the
    omission of cipher suites that do not support Perfect Forward
    Secrecy (Diffie-Hellman) causes some problems. This usually caused
    by an well-intentioned but poorly executed attempts to strengthen
    TLS security by setting tls-cipher on the server or some embedded
    OSes with stripped down SSL (e.g. MikroTik).<br>
    <br>
    To solve this problem the problem, set the tls-cipher settings on
    the server to reasonable default like tls-cipher
    \"DEFAULT:!EXP:!PSK:!SRP:!kRSA\". To work around the problem on the
    client add the custom option tls-cipher DEFAULT on the Android
    client.<br>
  </body>
</html>

--------------050204040306030905040902--

