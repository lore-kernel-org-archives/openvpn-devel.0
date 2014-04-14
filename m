Message-ID: <534BA0EE.1050103@...515...>
Date: Mon, 14 Apr 2014 11:48:46 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <534B98A4.7020806@...515...>
	<20140414082858.GB16637@...1296...>
In-Reply-To: <20140414082858.GB16637@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN PolarSSL builds?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Mon, Apr 14, 2014 at 11:13:24AM +0300, Samuli Sepp=E4nen wrote:
>> Currently all of the binary builds we provide[*] are linked to OpenSSL.
>> Would having both OpenSSL and PolarSSL builds make sense (e.g. starting
>> with 2.4)?
> I think it would be a nice option.  We could even start with 2.3.4 with
> that, at least for windows... (if PolarSSL can be cross-compiled for
> windows...)
>
I think the "cross-compile on Windows" part is the trickiest part. That
said, on Debian/Ubuntu we'd probably need to use some package name
tricks like:

"openvpn" (a metapackage)
"openvpn_openssl", provides openvpn (=3Dopenvpn+openssl)
"openvpn_polarssl", provides openvpn (=3Dopenvpn+polarssl)

Agi: do you have any suggestions on how to best handle this kind of
scenario?

Also, if we don't wish maintain our own set of PolarSSL .deb packages
we'd have to limit ourselves to fairly recent Debian/Ubuntu versions.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


