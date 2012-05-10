Message-ID: <4FAC3C2C.7020504@...1227...>
Date: Fri, 11 May 2012 00:07:40 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...> <4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
	<CAOazyz1u-WhMYD5VykW2nzLyJzWr8-8wJ3pqwCMBwqggkpbLiA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D3E@...1436...>
	<CAOazyz30FaAPsha7hyD9cAwvRWkq_4i9Cme0mFJDpX0VdSb7=w@...278...>
	<4FABDBF7.406@...1114...>
	<CAP+U6tK5a-QFW1+=B-6AOTa3nqHheETs9mSuLMGmUQ5WS+c3vw@...278...>
In-Reply-To: <CAP+U6tK5a-QFW1+=B-6AOTa3nqHheETs9mSuLMGmUQ5WS+c3vw@...278...>
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
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I am listing a few requirements that are not discussed before but may
still be important and non obvious. These at least people not involved
with the Android platform a better picture of required changes.
> To allow OpenVPN to be properly refactored afterwards, the important
> part is probably to get the external interfaces correct (which never
> works in practice, but it would be nice to get close...).
>
> The main undecided points regarding the interface side of things appear to be:
> * How to pass the fds back and forth: Special-case the management
>   interface for unix domain sockets or use a dedicated unix domain
>   socket for special operations. Could this potentially be the same
>   interface that was discussed for some of the windows privilege
>   separation approaches?
> * How to call OpenVPN from Java. Via thin JNI wrapper or as a regular
>   executable.
> * The precise names of the newly introduced management commands.

* How to pass routing and other information over the managment
interface. This is important since OpenVpn for Linux needs
ROUTE_AFTER_TUN and IFCONFIG_AFTER_TUN and the Android API needs both
before TUN.
* If the TARGET_ANDROID (or call it TARGET_UNPRIVILEGED_USES_FDPASSING
or something generic) is an extra target or if TARGET_LINUX and
TARGET_ANDROID should one target. This will complicate a lot of things
without refactoring (see the before/after point)
* Openvpn for Android is the first platform which does allow non CIDR
routes (I think). In my port I print a warning in the GUI if I encounter
something stupid like 10.0.0.0 netmask 255.0.255.0. The same goes the
netmask of the ifconfig command.

Arne

P.S.: Sorry for double email, I sent from the wrong email in the first try.


