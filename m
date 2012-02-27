MIME-Version: 1.0
In-Reply-To: <CAOazyz2MWSWqf6L4XQYNBpCHL73vgZKB=StzLEL5s0oQjihJPA@...278...>
References: <CAOazyz2MWSWqf6L4XQYNBpCHL73vgZKB=StzLEL5s0oQjihJPA@...278...>
Date: Mon, 27 Feb 2012 03:11:19 +0200
Message-ID: <CAOazyz09NdwccVwLgpVAzpnBX-2X3dH5E+DS_2=KXpYWBJhNoA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [build] tap-windows
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Also signs and package.
Please test.

On Sun, Feb 26, 2012 at 4:49 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Hello,
>
> A repository is available[1], stripped down with only tap sources.
>
> To build use you need ddk available:
>> configure
>> build
>
> It builds winxp 32bit and win7 64bit I hope this is what the current
> installer is doing,
> as building the tap is kept secret.
>
> In the open source package we will provide vanilla devcon and not the modified
> tapinstaller which we do not have the sources of. I it is so important
> to hack computer
> and bypass Windows confirmation dialog.
>
> Left is to package it up.
>
> Alon.
>
> [1] https://github.com/alonbl/tap-windows/

