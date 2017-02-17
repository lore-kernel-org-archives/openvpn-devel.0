References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <0711f6e6-fd5a-72bc-74c0-70130379f117@...68...>
Date: Fri, 17 Feb 2017 18:49:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 17.02.2017 um 17:35 schrieb Emmanuel Deloget:
> I understand that I'm the new guy in town, but can you allow me to
> make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
> require at least version 1.0.2?

1.0.1 has also gone out of support, and I propose to let the distros
sort out the upgrading and if someone needs to go forward with his
OpenVPN version to a future 2.5.0 that would no longer work with 1.0.1,
they could always add another newer OpenSSL package as well, possibly in
a separate prefix, say /opt/openssl102.

Note that I am not speaking on behalf of the project, just personally,
and that out of the way, since this code isn't likely going to be part
of a stable release,
I propose that it be only compatible back to supported OpenSSL versions,
i. e. 1.0.2 and 1.1.0.


