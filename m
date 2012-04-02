MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Mon, 2 Apr 2012 11:55:18 +0200
Message-ID: <CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
	RNG
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Alon,

2012/4/2 Alon Bar-Lev <alon.barlev@...277...>:
> I also intend to work and cleanup the whole PolarSSL/OpenSSL mess...
>
> Design will be to introduce crypto engine callback structure,
> registering openssl and polarssl, in a way that code is using the
> callback structure while using runtime configuration one can select
> which engine to use (if both are available).

What would be the use-case for switching crypto libraries at runtime?
Would this be an important step towards the OpenVPN 3.0 concept?
(Otherwise this sounds like quite a bit of work and potentially more
processing overhead...)

Cheers
Fabian

