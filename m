Content-Type: multipart/alternative;
 boundary="------------mIwfIWo0jVxBjPEj0CMYsloy"
Message-ID: <58f13ba2-7565-3769-6a6b-595b9c3121de@...2666...>
Date: Tue, 21 Mar 2023 10:21:41 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230319075441.13021-1-info@...2666...>
 <202303201301.32KD18AU062879@...2054...>
From: Michael Baentsch <info@...2666...>
In-Reply-To: <202303201301.32KD18AU062879@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: using OpenSSL3 API for EVP
 PKEY type name reporting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------mIwfIWo0jVxBjPEj0CMYsloy
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Gert,

    thanks very much!

 > Have not investigated how to actually trigger these code lines.

If you're curious (TL;DR), below's a test FWIW:

The fix can be seen "in action" when using OpenVPN with a quantum-safe 
signature algorithm via oqs-provider:

Everything built into docker images:

1) New code in openquantumsafe/openvpn:23903fd579353c98:

# openvpn --version
OpenVPN 2.7_git [git:master/23903fd579353c98] x86_64-pc-linux-gnu [SSL 
(OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Mar 21 2023
library versions: OpenSSL 3.2.0-dev , LZO 2.10

2023-03-21 09:08:43 us=455158 10.0.5.3:37633 TLS: tls_multi_process: 
initial untrusted session promoted to trusted
WWRR2023-03-21 09:08:43 us=455383 10.0.5.3:37633 Control Channel: 
TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 192 
bit dilithium3, signature: dilithium3
2023-03-21 09:08:43 us=455406 10.0.5.3:37633 [oqsopenvpnclient] Peer 
Connection Initiated with [AF_INET]10.0.5.3:37633

--> Connection establishment OK


2) Old code in openquantumsafe/openvpn:838474145933199a

# openvpn --version
OpenVPN 2.7_git [git:master/838474145933199a] x86_64-pc-linux-gnu [SSL 
(OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Mar 14 2023
library versions: OpenSSL 3.2.0-dev , LZO 2.10

2023-03-21 09:10:59 us=432368 10.0.5.3:40978 TLS: tls_multi_process: 
initial untrusted session promoted to trusted
WWRR2023-03-21 09:10:59 us=432601 10.0.5.3:40978 Control Channel: 
TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 192 
bit unknown type, signature: dilithium3
2023-03-21 09:10:59 us=432619 10.0.5.3:40978 [oqsopenvpnclient] Peer 
Connection Initiated with [AF_INET]10.0.5.3:40978
2023-03-21 09:10:59 us=432634 10.0.5.3:40978 OpenSSL: 
error:04000065:object identifier routines::unknown nid
2023-03-21 09:10:59 us=432640 10.0.5.3:40978 TLS_ERROR: BIO read 
tls_read_plaintext error
2023-03-21 09:10:59 us=432648 10.0.5.3:40978 TLS Error: TLS object -> 
incoming plaintext read error
2023-03-21 09:10:59 us=432653 10.0.5.3:40978 TLS Error: TLS handshake failed

--> Connection setup failure

Regards,

--Michael

Am 20.03.23 um 14:01 schrieb Gert Doering:
> I have not tested this extensively, just subjected to GH to compile and
> run basic checks with OpenSSL 1.1.x and 3.0.x, and ran a few local tests
> (Linux + OpenSSL 1.1.1).  This all passed.  Have not investigated how
> to actually trigger these code lines.
>
> Your patch has been applied to the master and release/2.6 branch.
>
> commit 6c111be9b109a6dbcd39cac7821ea3dd78ff6adf (master)
> commit a05ec70edd5178aac7b7432c57878c32aa838013 (release/2.6)
> Author: Michael Baentsch
> Date:   Sun Mar 19 08:54:41 2023 +0100
>
>       using OpenSSL3 API for EVP PKEY type name reporting
>
>       Signed-off-by: Michael Baentsch<info@...2666...>
>       Acked-by: Arne Schwabe<arne@...1227...>
>       Message-Id:<20230319075441.13021-1-info@...2666...>
>       URL:https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26439.html
>       Signed-off-by: Gert Doering<gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>

--------------mIwfIWo0jVxBjPEj0CMYsloy
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi Gert,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">   thanks very much! <br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">&gt; Have not investigated how to
      actually trigger these code lines.</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">If you're curious (TL;DR), below's a
      test FWIW:<br>
    </div>
    <div class="moz-cite-prefix">
      <p>The fix can be seen "in action" when using OpenVPN with a
        quantum-safe signature algorithm via oqs-provider:</p>
      <p>Everything built into docker images: <br>
      </p>
      <p>1) New code in openquantumsafe/openvpn:23903fd579353c98:<br>
      </p>
      <p><font size="2" face="Courier New, Courier, monospace"># openvpn
          --version<br>
          OpenVPN 2.7_git [git:master/23903fd579353c98]
          x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO]
          [AEAD] [DCO] built on Mar 21 2023<br>
          library versions: OpenSSL 3.2.0-dev , LZO 2.10<br>
        </font> <font size="2" face="Courier New, Courier, monospace"><br>
        </font> </p>
      <font size="2" face="Courier New, Courier, monospace"> </font>
      <p><font size="2" face="Courier New, Courier, monospace">2023-03-21
          09:08:43 us=455158 10.0.5.3:37633 TLS: tls_multi_process:
          initial untrusted session promoted to trusted<br>
          WWRR2023-03-21 09:08:43 us=455383 10.0.5.3:37633 Control
          Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer
          certificate: 192 bit dilithium3, signature: dilithium3<br>
          2023-03-21 09:08:43 us=455406 10.0.5.3:37633
          [oqsopenvpnclient] Peer Connection Initiated with
          [AF_INET]10.0.5.3:37633</font><br>
      </p>
      <p>--&gt; Connection establishment OK</p>
      <p><br>
      </p>
      <p>2) Old code in openquantumsafe/openvpn:838474145933199a<br>
      </p>
      <p><font size="2" face="Courier New, Courier, monospace"># openvpn
          --version<br>
          OpenVPN 2.7_git [git:master/838474145933199a]
          x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO]
          [AEAD] [DCO] built on Mar 14 2023<br>
          library versions: OpenSSL 3.2.0-dev , LZO 2.10<br>
        </font> <font size="2" face="Courier New, Courier, monospace"><br>
        </font> </p>
      <font size="2" face="Courier New, Courier, monospace"> 2023-03-21
        09:10:59 us=432368 10.0.5.3:40978 TLS: tls_multi_process:
        initial untrusted session promoted to trusted<br>
        WWRR2023-03-21 09:10:59 us=432601 10.0.5.3:40978 Control
        Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer
        certificate: 192 bit unknown type, signature: dilithium3<br>
        2023-03-21 09:10:59 us=432619 10.0.5.3:40978 [oqsopenvpnclient]
        Peer Connection Initiated with [AF_INET]10.0.5.3:40978<br>
        2023-03-21 09:10:59 us=432634 10.0.5.3:40978 OpenSSL:
        error:04000065:object identifier routines::unknown nid<br>
        2023-03-21 09:10:59 us=432640 10.0.5.3:40978 TLS_ERROR: BIO read
        tls_read_plaintext error<br>
        2023-03-21 09:10:59 us=432648 10.0.5.3:40978 TLS Error: TLS
        object -&gt; incoming plaintext read error<br>
        2023-03-21 09:10:59 us=432653 10.0.5.3:40978 TLS Error: TLS
        handshake failed</font></div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">--&gt; Connection setup failure</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Regards,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">--Michael<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Am 20.03.23 um 14:01 schrieb Gert
      Doering:<br>
    </div>
    <blockquote type="cite"
      cite="mid:202303201301.32KD18AU062879@...2054...">
      <pre class="moz-quote-pre" wrap="">I have not tested this extensively, just subjected to GH to compile and
run basic checks with OpenSSL 1.1.x and 3.0.x, and ran a few local tests
(Linux + OpenSSL 1.1.1).  This all passed.  Have not investigated how
to actually trigger these code lines.

Your patch has been applied to the master and release/2.6 branch.

commit 6c111be9b109a6dbcd39cac7821ea3dd78ff6adf (master)
commit a05ec70edd5178aac7b7432c57878c32aa838013 (release/2.6)
Author: Michael Baentsch
Date:   Sun Mar 19 08:54:41 2023 +0100

     using OpenSSL3 API for EVP PKEY type name reporting

     Signed-off-by: Michael Baentsch <a class="moz-txt-link-rfc2396E" href="mailto:info@...2666...">&lt;info@...2666...&gt;</a>
     Acked-by: Arne Schwabe <a class="moz-txt-link-rfc2396E" href="mailto:arne@...1227...">&lt;arne@...1227...&gt;</a>
     Message-Id: <a class="moz-txt-link-rfc2396E" href="mailto:20230319075441.13021-1-info@...2666...">&lt;20230319075441.13021-1-info@...2666...&gt;</a>
     URL: <a class="moz-txt-link-freetext" href="https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26439.html">https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26439.html</a>
     Signed-off-by: Gert Doering <a class="moz-txt-link-rfc2396E" href="mailto:gert@...1296...">&lt;gert@...1296...&gt;</a>


--
kind regards,

Gert Doering

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------mIwfIWo0jVxBjPEj0CMYsloy--

