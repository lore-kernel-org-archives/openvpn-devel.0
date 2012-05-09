MIME-Version: 1.0
In-Reply-To: <4FAAE0A1.2080808@...1227...>
References: <4FAAE0A1.2080808@...1227...>
Date: Thu, 10 May 2012 01:09:28 +0300
Message-ID: <CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hmmm... the fact that you are not using git, and create separate
branch for the changes makes it very difficult to peak.

I see a mix of changes and a separate build system which I am not sure
is needed. You build openvpn as a shared library, it is OK, I had this
on my list, but why not use the current build to do so?

I suggest you clone the repository at github, create a branch and
order your changes.

Regards,
Alon Bar-Lev.

On Thu, May 10, 2012 at 12:24 AM, Arne Schwabe <arne@...1227...> wrote:
> Hello,
>
> I have developed the port of openvpn for Android 4.0:
> https://play.google.com/store/apps/details?id=de.blinkt.openvpn and
> http://code.google.com/p/ics-openvpn/
>
> The API of Android 4.0 requires that openvpn runs as completely
> unprivileged process. There all opening of tun, adding of routes,
> ifconfig etc. has to be done by another process.
>
> This patch implements an API to allow pushing routes, dns, tun over the
> management interface (unix socket). Also on Android 4.0 the connection
> for the control has to be protect via an API call from the Java GUI.
>
> Basically I am using the needok feature of the management protocol to
> push all relevant information to the GUI or to request information. I
> have not split the patch into multiple small patches because it should
> be first discussed if this is right architectural way.
>
>
> Arne
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

