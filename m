MIME-Version: 1.0
In-Reply-To: <5006B987.2060305@...1114...>
References: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
	<CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
	<CAEsd45R3Or3izDGLamLOoft=xSNBNH8Qq8ztWb+N5Um4nitdJg@...278...>
	<5006B987.2060305@...1114...>
Date: Wed, 18 Jul 2012 16:31:56 +0300
Message-ID: <CAOazyz173OWMQ2=XmjfExJ3G8Q5srhqbd+2awh+3nDi7L_OZ3A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] New build system questions
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Wed, Jul 18, 2012 at 4:26 PM, David Sommerseth > Agreed, this
sounds like a feature regression.
>
> Dynamic loading requires dlopen() and such (provided by libdl) and
> when compiled non-static, all this dlopen() stuff happens
> automatically, as the linker have instructed the binary what to load
> and which symbols to prepare for.
>
> However, when building statically, I presume you need to explicit link
> in libdl, to get those support functions - all the symbol lookup
> anyway needs to be tackled by the application.  But static builds
> should not exclude the plug-in feature.

1. ELF does not allow static image to use dynamic bindings.
Try this at previous versions, if you get this working please notify me.

2. There is no restriction of building and linking static dependencies
with dynamic module, as long as they share the same PIC state.

Alon.

