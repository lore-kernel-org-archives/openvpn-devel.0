MIME-Version: 1.0
In-Reply-To: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
Date: Wed, 2 May 2012 12:15:25 +0300
Message-ID: <CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
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
To: Gauri Bhave <gaurib123@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

OpenVPN is basically UTF-8 enabled.
There was a recent patch to fix some issue with the management
interface in this regard.
Most probably you will need to convert UCS-2 to UTF-8 when sending the
user/password into openvpn.
So you can try out the master branch and see if it works for you.

Alon.

On Wed, May 2, 2012 at 12:10 PM, Gauri Bhave <gaurib123@...277...> wrote:
> Hi,
>
> I am customizing the openvpn GUI to support multiple languages. I want to
> connect using a non ASCII username, Say a chinese or hindi user name. Is it
> possible in Open VPN.
>
> Thanks
> Gauri Bhave
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

