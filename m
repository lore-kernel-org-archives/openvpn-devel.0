Message-ID: <9e0cf0bf0802162232n40953c6bjac66494ac1cf7e64@...278...>
Date: Sun, 17 Feb 2008 08:32:08 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4aff28800802161507r3c5ccf91vb2bfc0d56951906a@...278...>
MIME-Version: 1.0
References: <4aff28800802160916r506572a0r44a9e619e31ce5ee@...278...>
	<9e0cf0bf0802160925w2dd86c02mb6f8dd5cfd4ab9e5@...278...>
	<4aff28800802160957i114f38f4o2fdd483a780ff203@...278...>
	<9e0cf0bf0802161014j6de5ddd2l37f42bbd835d4a90@...278...>
	<4aff28800802161507r3c5ccf91vb2bfc0d56951906a@...278...>
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
To: Diaa Sami <diaasami@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks!
I solved something similar to this using a cross compiler, with newer
gcc than I used in msys.

Can you please try this one?
http://alon.barlev.googlepages.com/pkcs11-helper-1.06_beta1.tar.bz2

If it does not work, please provide a full build log again... The
linker cannot find proper libraries.

Also, if I remember correctly, you need to reference the DLL and not
the lib, modify:
OPENSSL_LIBS=-L/c/openvpn_job/openssl-0.9.7m-patched/out/ -leay32 -lssl32
to:
OPENSSL_LIBS=-L/c/openvpn_job/openssl-0.9.7m-patched/ -leay32 -lssl32

Thanks!

On 2/17/08, Diaa Sami <diaasami@...277...> wrote:
> On Feb 16, 2008 8:14 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> >
> > I see nothing wrong here...
> > Can you please remove ac_cv_type_size_t=no and --disable-static from configure?
> > And also end me the complete build log?
> >
>
> I did and here are the new config.log and build output
>
>

