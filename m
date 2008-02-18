Message-ID: <4aff28800802171619k135c1965m52ad9ab11394ad6b@...278...>
Date: Mon, 18 Feb 2008 02:19:18 +0200
From: "Diaa Sami" <diaasami@...277...>
In-Reply-To: <9e0cf0bf0802171248ra12c019g4bbbef1ceee9647c@...278...>
MIME-Version: 1.0
References: <4aff28800802160916r506572a0r44a9e619e31ce5ee@...278...>
	<9e0cf0bf0802160925w2dd86c02mb6f8dd5cfd4ab9e5@...278...>
	<4aff28800802160957i114f38f4o2fdd483a780ff203@...278...>
	<9e0cf0bf0802161014j6de5ddd2l37f42bbd835d4a90@...278...>
	<4aff28800802161507r3c5ccf91vb2bfc0d56951906a@...278...>
	<9e0cf0bf0802162232n40953c6bjac66494ac1cf7e64@...278...>
	<4aff28800802171046v2b37359elcba3cdf4d14223de@...278...>
	<9e0cf0bf0802171248ra12c019g4bbbef1ceee9647c@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN 2.1rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Feb 17, 2008 10:48 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On Feb 17, 2008 8:46 PM, Diaa Sami <diaasami@...277...> wrote:
> > I tried this one but it's the same, no DLL is created even after
> > linking with the DLLs instead of the the libs.
> >
> > Here are the new config.log and build.log so you can find what's wrong.
>
> Thanks!
> First, you don't need the -lssl32 for pkcs11-helper.
>
> But it still does not find libeay32.dll...

I think it's something with linking with DLLs, unfortunately I didn't
do it before on MinGW
but on VC you only link to the import library not the DLL itself.

> Do you sure the openssl is built correctly?

Yes, because the static version of pkcs-helper builds successfully and
I used it to build openvpn successfully.

> Do you have libeay32.dll at "/c/openvpn_job/openssl-0.9.7m-patched"?
> What is the output of "file" command on libeay32.dll?

Yes, the output of file is Ok as far as I can see, it's
../openssl-0.9.7m-patched/libeay32.dll; MS-DOS executable PE  for MS
Windows (DLL) (console) Intel 80386 32-bit

