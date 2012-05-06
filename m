MIME-Version: 1.0
Date: Sun, 6 May 2012 19:55:06 +0300
Message-ID: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [RFC] Split plugins into their own repositories
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

Hello,

Now, I also have the courage to ask one more question regarding build....

We currently have:
- auth-pam
- defer
- down-root
- examples

Distribution wise it will be best to allow admin to install plugins as
own package which requires openvpn, allowing select specific plugins,
while each has own release cycle and versioning.

I already made the openvpn-plugin.h available in /usr/include, so
there is no real reason to keep the plugins in openvpn tree, as they
can be complied using their own separate build system.

for example, if we take RHEL, we can install the following to use the
auth-pam plugin:

openvpn
openvpn-plugin-auth-pam

To build plugin we need openvpn-devel.

What do you say?

BTW: next will be probably to split out the contrib... :)

Alon

