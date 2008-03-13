Message-ID: <9e0cf0bf0803130645i1f84a228r2b983a00e7159faa@...278...>
Date: Thu, 13 Mar 2008 15:45:33 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <47D7F911.50307@...1068...>
MIME-Version: 1.0
References: <478C94C4.1050409@...1068...>
	<9e0cf0bf0801150345i749f5ca6na1f8343b6da390fc@...278...>
	<9e0cf0bf0801150345p4639a831ub8f85fd56bda48db@...278...>
	<478CAD6A.3010808@...1068...>
	<9e0cf0bf0801150522x72621b20pc36373986f2ad8a1@...278...>
	<47D7CBC2.6020606@...1068...>
	<9e0cf0bf0803120802x53ed773ev38f25064069909e9@...278...>
	<47D7F911.50307@...1068...>
Subject: Re: [Openvpn-devel] NTLMv2 patch corrected
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
To: Mirek Zajic <zajic@...1068...>
Cc: openvpn-devel@lists.sourceforge.net

On 3/12/08, Mirek Zajic <zajic@...1068...> wrote:
>  > Just noticed that openvpn has: openvpn_gettimeofday() which works also
>  > for WIN32... Maybe use this one?
>  >
>  >
>
> openvpn_time works fine, why to change?

I remember you used gettimeofday in previous versions... I missed the
openvpn_gettimeofday() availability... Maybe the protocol do require
more precise timing... I truly don't know.

>
> >>  +    msg_buf[sb_offset + 5] = (unsigned char)((*msg_bufpos & 0xff00) >> 8);
>  >>
>  >
>  > always & such with 0xff.
>  >
>
> Please explain, I don't understand

msg_buf[sb_offset + 5] = (unsigned char)((*msg_bufpos >> 8) & 0xff);

> Some Microsoft compilers doesn't support long long, but they support
>  __int64. The same is with LL/Ui64 postfix. I think that this is correct.
>  But I'm not sure about  the location. Maybe that it should be placed in
>  some common header (common.h?) for further usage by other modules.

This is James call... But currently OpenVPN cannot be compiled on
these compilers anyway... So adding these macros is not required.

Anyway... This is about as far as I can help.

Alon.

