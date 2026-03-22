Content-Type: multipart/alternative;
 boundary="------------4vIUiXnQ0Gymy6iGBtILGNOQ"
Message-ID: <6253558a-1f0a-4484-8bdb-455b9b1bd01d@...1227...>
Date: Sun, 22 Mar 2026 13:40:32 +0100
MIME-Version: 1.0
References: <ab9xsPqPbK_jLNF2@...3014...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ab9xsPqPbK_jLNF2@...3014...>
Subject: Re: [Openvpn-devel] [PATCH] ssl_verify_openssl: use official
 ASN1_STRING_ API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rudi Heitbaum <rudi@...2993...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------4vIUiXnQ0Gymy6iGBtILGNOQ
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


Am 22.03.2026 um 05:36 schrieb Rudi Heitbaum via Openvpn-devel:
> ASN1_STRING are now opaque types in OpenSSL 4.x — the internal data and
> length fields are no longer directly accessible. Use the accessor API
> instead. Accessors have been available since OpenSSL 1.1.0
>
> The ASN1_STRING_length accessor is already in use, but not consistently
> applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0_data
> which allows for successful build of OpenSSL 4.x
>
> Signed-off-by: Rudi Heitbaum<rudi@...2993...>

Looks good and the GIthub build for it in the PR are also green with 
aws-lc and libressl (ssl_verify_openssl: use official ASN1_STRING_ API 
by heitbaum · Pull Request #1003 · OpenVPN/openvpn 
<https://github.com/OpenVPN/openvpn/pull/1003>)

Acked-By: Arne Schwabe <arne@...1227...>

--------------4vIUiXnQ0Gymy6iGBtILGNOQ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 22.03.2026 um 05:36 schrieb Rudi
      Heitbaum via Openvpn-devel:<br>
    </div>
    <blockquote type="cite" cite="mid:ab9xsPqPbK_jLNF2@...3014...">
      <pre wrap="" class="moz-quote-pre">ASN1_STRING are now opaque types in OpenSSL 4.x — the internal data and
length fields are no longer directly accessible. Use the accessor API
instead. Accessors have been available since OpenSSL 1.1.0

The ASN1_STRING_length accessor is already in use, but not consistently
applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0_data
which allows for successful build of OpenSSL 4.x

Signed-off-by: Rudi Heitbaum <a class="moz-txt-link-rfc2396E" href="mailto:rudi@...2993...">&lt;rudi@...2993...&gt;</a></pre>
    </blockquote>
    <br>
    <p>Looks good and the GIthub build for it in the PR are also green
      with aws-lc and libressl (<a
        href="https://github.com/OpenVPN/openvpn/pull/1003">ssl_verify_openssl:
        use official ASN1_STRING_ API by heitbaum · Pull Request #1003 ·
        OpenVPN/openvpn</a>) </p>
    <p>Acked-By: Arne Schwabe <a class="moz-txt-link-rfc2396E" href="mailto:arne@...1227...">&lt;arne@...1227...&gt;</a></p>
  </body>
</html>

--------------4vIUiXnQ0Gymy6iGBtILGNOQ--

