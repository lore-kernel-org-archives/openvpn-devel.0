From: Roy Marples <roy@...876...>
Date: Wed, 8 Nov 2006 14:21:27 +0000
References: <200611081343.07350.uberlord@...594...>
In-Reply-To: <200611081343.07350.uberlord@...594...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nfeUFxLXjgsS2Rm"
Message-Id: <200611081421.27156.roy@...876...>
Subject: Re: [Openvpn-devel] [PATCH] txqueuelen for persistent interfaces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_nfeUFxLXjgsS2Rm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 08 November 2006 13:43, Roy Marples wrote:
> Hi.
>
> openvpn does not apply the --txqueuelen option to persistent interfaces
> made with --mktun [1]
>
> Attached are patches to 2.0.7 and 2.1_rc1 that fix the issue.
>
> Thanks!
>
> [1] http://bugs.gentoo.org/show_bug.cgi?id=150791

And here are the patches - oops!

-- 
Roy Marples <roy@...876...>

--Boundary-00=_nfeUFxLXjgsS2Rm--

