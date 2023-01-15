Message-ID: <ee7b4c257b30a2b91d28eab827fd99ee61d1d48a.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 15 Jan 2023 11:17:47 -0500
In-Reply-To: <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
 <0456a9e2e317af58f1aa6947c768ac7853c06485.camel@...2316...>
 <334bc5ad-1d55-208b-bbaf-2233c4708d9f@...1227...>
 <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
 <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, 2023-01-15 at 16:34 +0100, Arne Schwabe wrote:
> Am 15.01.23 um 16:22 schrieb James Bottomley:
> > On Sun, 2023-01-15 at 15:22 +0100, Arne Schwabe wrote:
[...]
> > >   So you are right in the sense that the Apache2 is just
> > > a normal library to link for most purposes, the GPL licenses are
> > > special in the way that they want to cover the whole source
> > > code/binary. Sometimes this feature of the GPL is called viral by
> > > opponents of the license.
> > 
> > Not for system libraries ... that's what the system library
> > exception is all about.
> 
> Yes but neither mbed TLS nor OpenSSL is a system library on Windows
> or macOS. And even mbed TLS is sketchy as many distributions do not
> have in their base system. So just assume, at least for the sake of
> argument that they are not. In that case I think we need this
> exception. So I am  asking if you are willing to allow this exception
> to the license even though you think it is unnecessary to make the
> people that think that it  is needed happy?

In that case your proposed exception doesn't work.  You've modelled it
on the OpenSSL exception which was designed to cover the use case where
OpenSSL *is* a system library (thus covered by the system library
exception) but imposes incompatible additional restrictions on whole
binary, specifically the GPLv2 pieces.

To make this work assuming the crypto library isn't a system one, you
need an exception to the section 2 requirement to ship the whole under
GPLv2 ... or a simple declaration that you think openssl and mbedtls
are system libraries for the purposes of OpenVPN, so the system library
exception applies to them regardless of how they are shipped.

James


