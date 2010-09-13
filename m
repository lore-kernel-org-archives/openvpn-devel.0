MIME-Version: 1.0
In-Reply-To: <20100913182543.12172.qmail@...1287...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
Date: Mon, 13 Sep 2010 21:15:48 +0200
Message-ID: <AANLkTi=a+_88TDwR_8soAkY6EKqzn8u3Kd2rsq8Oc9S2@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, Sep 13, 2010 at 8:25 PM, Peter Stuge <peter@...1287...> wrote:
> autotools is absolutely alien in Windows, and to be honest a bit of a
> hassle to set up if you're already a VS wizard.

In OpenVPN upstream provides binaries using mingw anyway.
So there is no need to support any other environment for Windows.
This makes it easy.
Also, please keep in mind that OpenVPN is not a library... so much
easier to manage.

>> and the mixture of different projects: openvpn, tap, windows
>> installer, easy-rsa.
>
> How can the installer situation be improved? I want to make an NSIS
> installer as well, and I would quite like to keep it *within* the

I just saying that most users do not interested in compiling the tap
driver, also compiling the tap driver requires Microsoft DDK. So
separating the tap into its own release management would be wise... a
separate MSI for the TAP that can be embedded within other installers.

Easy-rsa has nothing to do with openvpn, it is great that it is
provided, but as a separate process, fix in easy-rsa should not modify
openvpn release

The same for Windows installer, a fix in Windows installer should not
modify openvpn version, as it has nothing to do with it.

Alon.

