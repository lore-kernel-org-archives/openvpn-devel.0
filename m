MIME-Version: 1.0
In-Reply-To: <CAB0ctLqzb8RY=MaTDLi=wx4kXrO3sgRVE2h9hHGwH7v8DBucSg@...278...>
References: <CAB0ctLqzb8RY=MaTDLi=wx4kXrO3sgRVE2h9hHGwH7v8DBucSg@...278...>
Date: Fri, 15 Jun 2012 08:37:20 +0300
Message-ID: <CAOazyz0BEPmF7dhnf-EB6N+gKZDtatMXAirxvzft9s0Sv4EViw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] RHEL's rpmbuild needs slight modification to
 build from tarball from openvpn-2.3-alpha1.tar.gz
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: George Alexander <george.alexander@...1730...>
Cc: openvpn-devel@lists.sourceforge.net

You are correct.
This was fixed in master.

On Fri, Jun 15, 2012 at 2:23 AM, George Alexander
<george.alexander@...1730...> wrote:
> Hi everyone, I was building an rpm the other day of the latest release (it
> looks great, can't wait to try it out) and noticed a lil problem: It does=
n't
> like "-" in version names...
>
> [root@...185... ~]# rpmbuild -tb openvpn-2.3-alpha1.tar.gz
> error: line 19: Illegal char '-' in version: Version: =C2=A0 =C2=A0 =C2=
=A0 =C2=A02.3-alpha1
>
> Solution is simple -- untar, change directory name, change version in .sp=
ec
> file, re-tar/gz, re-run rpmbuild:
> [root@...185... ~]# tar zxf openvpn-2.3-alpha1.tar.gz
> [root@...185... ~]# mv openvpn-2.3-alpha1 openvpn-2.3_alpha1
> [root@...185... ~]# sed -i "s/2\.3-alpha/2\.3_alpha/"
> openvpn-2.3_alpha1/openvpn.spec
> [root@...185... ~]# tar czf openvpn-2.3_alpha1.tar.gz openvpn-2.3_alpha1/
> [root@...185... ~]# rpmbuild -tb openvpn-2.3_alpha1.tar.gz
>
> Now it's good to go for the rpmbuild -tb. =C2=A0I guess I'm the only one =
building
> this for CentOS -- I didn't see anything on google about anyone else havi=
ng
> this problem. =C2=A0Anyway I think it'd be nice for 2.3_alpha2 to not hav=
e a
> dash, if that fits with your dispositions :)
> -George
>
>
> -------------------------------------------------------------------------=
-----
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

