Content-Type: multipart/alternative;
 boundary="------------dPh2mV7fZeYOq4V4I0OwWKSy"
Message-ID: <8921066d-13ec-4fc0-bfa6-17cfcd82e970@...1227...>
Date: Thu, 20 Jun 2024 02:43:49 +0200
MIME-Version: 1.0
References: <20240618120219.5053-1-gert@...1296...>
 <202406181630.45IGU5vu098122@...2054...>
 <ZnKodXfUYfL5LUlJ@...1296...>
 <d2a5a966414745e2942f0cfa62db3fdc@...2507...>
 <ZnLg-79txAYA-jn-@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ZnLg-79txAYA-jn-@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: mbedtls: Remove support for
 old TLS versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------dPh2mV7fZeYOq4V4I0OwWKSy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

it should happen during start-up.
> I would argue for
>
>   - we log "minimum supported version is 1.2" and go on
>
> or
>
>   - we log "minimum supported version is 1.2" and exit
>
> both is acceptable.  It will break people's setups in different ways,
> though...  the first will pretend all is well, and older clients can no
> longer connect, while the second one will break everything, so making it
> more obvious.
>
Strong vote for going on. On many OpenSSL configuration and also 
distribution trying to use TLS 1.0 will already silently give you only 
TLS 1.2+. So no reason to behave different with mbed TLS.

Arne

--------------dPh2mV7fZeYOq4V4I0OwWKSy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <span style="white-space: pre-wrap">it should happen during start-up.</span>
    <blockquote type="cite" cite="mid:ZnLg-79txAYA-jn-@...1296...">
      <pre class="moz-quote-pre" wrap="">
I would argue for

 - we log "minimum supported version is 1.2" and go on

or 

 - we log "minimum supported version is 1.2" and exit

both is acceptable.  It will break people's setups in different ways,
though...  the first will pretend all is well, and older clients can no
longer connect, while the second one will break everything, so making it
more obvious.

</pre>
    </blockquote>
    <p>Strong vote for going on. On many OpenSSL configuration and also
      distribution trying to use TLS 1.0 will already silently give you
      only TLS 1.2+. So no reason to behave different with mbed TLS.</p>
    <p>Arne<span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------dPh2mV7fZeYOq4V4I0OwWKSy--

