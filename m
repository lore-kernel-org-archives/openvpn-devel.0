MIME-Version: 1.0
From: George Alexander <george.alexander@...1730...>
Date: Thu, 14 Jun 2012 18:23:23 -0500
Message-ID: <CAB0ctLqzb8RY=MaTDLi=wx4kXrO3sgRVE2h9hHGwH7v8DBucSg@...278...>
Content-Type: multipart/alternative; boundary=f46d043c07d6c9001404c276fe8a
Subject: [Openvpn-devel] RHEL's rpmbuild needs slight modification to build
	from tarball from openvpn-2.3-alpha1.tar.gz
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f46d043c07d6c9001404c276fe8a
Content-Type: text/plain; charset=ISO-8859-1

Hi everyone, I was building an rpm the other day of the latest release (it
looks great, can't wait to try it out) and noticed a lil problem: It
doesn't like "-" in version names...

[root@...185... ~]# rpmbuild -tb openvpn-2.3-alpha1.tar.gz
error: line 19: Illegal char '-' in version: Version:        2.3-alpha1

Solution is simple -- untar, change directory name, change version in .spec
file, re-tar/gz, re-run rpmbuild:
[root@...185... ~]# tar zxf openvpn-2.3-alpha1.tar.gz
[root@...185... ~]# mv openvpn-2.3-alpha1 openvpn-2.3_alpha1
[root@...185... ~]# sed -i "s/2\.3-alpha/2\.3_alpha/"
openvpn-2.3_alpha1/openvpn.spec
[root@...185... ~]# tar czf openvpn-2.3_alpha1.tar.gz openvpn-2.3_alpha1/
[root@...185... ~]# rpmbuild -tb openvpn-2.3_alpha1.tar.gz

Now it's good to go for the rpmbuild -tb.  I guess I'm the only one
building this for CentOS -- I didn't see anything on google about anyone
else having this problem.  Anyway I think it'd be nice for 2.3_alpha2 to
not have a dash, if that fits with your dispositions :)
-George

--f46d043c07d6c9001404c276fe8a
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div>Hi everyone, I was building an rpm the other day of the latest release=
 (it looks great, can&#39;t wait to try it out) and noticed a lil problem: =
It doesn&#39;t like &quot;-&quot; in version names...</div><div><br></div>

<div>[root@...185... ~]# rpmbuild -tb openvpn-2.3-alpha1.tar.gz</div><div>e=
rror: line 19: Illegal char &#39;-&#39; in version: Version: =A0 =A0 =A0 =
=A02.3-alpha1</div><div><br></div><div>Solution is simple -- untar, change =
directory name, change version in .spec file, re-tar/gz, re-run rpmbuild:</=
div>

<div>[root@...185... ~]# tar zxf openvpn-2.3-alpha1.tar.gz</div><div>[root@=
...185... ~]# mv openvpn-2.3-alpha1 openvpn-2.3_alpha1</div><div>[root@...1386...=
85... ~]# sed -i &quot;s/2\.3-alpha/2\.3_alpha/&quot; openvpn-2.3_alpha1/op=
envpn.spec</div>

<div>[root@...185... ~]# tar czf openvpn-2.3_alpha1.tar.gz openvpn-2.3_alph=
a1/<br>[root@...185... ~]# rpmbuild -tb openvpn-2.3_alpha1.tar.gz</div><div=
><br></div><div>Now it&#39;s good to go for the rpmbuild -tb. =A0I guess I&=
#39;m the only one building this for CentOS -- I didn&#39;t see anything on=
 google about anyone else having this problem. =A0Anyway I think it&#39;d b=
e nice for 2.3_alpha2 to not have a dash, if that fits with your dispositio=
ns :)</div>

<div>-George</div><div><br></div>

--f46d043c07d6c9001404c276fe8a--

