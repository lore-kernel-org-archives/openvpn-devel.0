MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 05 Mar 2017 14:25:51 +0000
Message-ID: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
Content-Type: multipart/alternative; boundary=f403045f1a1eed0a490549fc8e06
Subject: [Openvpn-devel] could be gitlab-ci an alternative to buildbot cloud?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403045f1a1eed0a490549fc8e06
Content-Type: text/plain; charset=UTF-8

Hello,

there was some buzz related to improvement of testing system, like
patchwork.
we tried gitlab-ci on our internal project, it looks very promising.

since openvpn is already hosted on gitlab.com, there's a possibility of

1) users can add their own gitlab-ci agents to the repo
2) it might be even windows agents
3) build results are publicly available (not easy to get from buildbot)

it looks like a big step, and it is hard to predict its result. but, I
think we can try and have a look at it.
thoughts?

Cheers,
Ilya Shipitsin

p.s. for our internal projects gitlab agents are always available, I did
not try yet how it works when some agents are unavalaible

--f403045f1a1eed0a490549fc8e06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>there was some buzz related to improvement of tes=
ting system, like patchwork.</div><div>we tried gitlab-ci on our internal p=
roject, it looks very promising.</div><div><br></div><div>since openvpn is =
already hosted on <a href=3D"http://gitlab.com">gitlab.com</a>, there&#39;s=
 a possibility of</div><div><br></div><div>1) users can add their own gitla=
b-ci agents to the repo</div><div>2) it might be even windows agents</div><=
div>3) build results are publicly available (not easy to get from buildbot)=
</div><div><br></div><div>it looks like a big step, and it is hard to predi=
ct its result. but, I think we can try and have a look at it.</div><div>tho=
ughts?</div><div><br></div><div>Cheers,</div><div>Ilya Shipitsin</div><div>=
<br></div><div>p.s. for our internal projects gitlab agents are always avai=
lable, I did not try yet how it works when some agents are unavalaible</div>

--f403045f1a1eed0a490549fc8e06--

