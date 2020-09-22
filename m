From: Antonio Quartulli <a@...2181...>
Message-ID: <2b7386c1-fd6d-7dcb-80fe-8453863fe420@...2181...>
Date: Tue, 22 Sep 2020 16:17:56 +0200
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] Introducing the OpenVPN Data Channel Offload Linux
 kernel module (ovpn-dco)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Antonio Quartulli <antonio@...515...>

Dear all,

OpenVPN Inc.[1] and me are happy to announce that today we have released
to the public our work-in-progress project called "ovpn-dco".

ovpn-dco stands for "OpenVPN Data Channel Offload".
It is a Linux kernel module and it implements all required
functionalities to handle the OpenVPN data channel.

In other words, when using ovpn-dco, the OpenVPN software will not send
data traffic back and forth between user and kernel space (for
encryption/decryption and routing), but operations on payloads will take
place in the Linux kernel.

Moving the data channel to kernel space is expected to finally remove
that bottleneck that has long prevented OpenVPN to scale better.
This is just the first step towards a feature-complete kernel based
OpenVPN driver and we will continue to work on improving performance and
 implementing more features.

The project is under heavy development, therefore APIs, data structures
and anything else may drastically change in the following months.

Our goal is to bring ovpn-dco up-to-the-standard with the rest of the
Linux kernel and then submit it for review and inclusion to the netdev
community.

Clients currently able to leverage on the ovpn-dco kernel module are the
OpenVPN3 reference client[2] and the OpenVPN3 Linux client[3] will
include ovpn-dco support in the next release. Support for OpenVPN2 is
planned.

ovpn-dco is released under GPLv2 and everybody is welcome to run, crash
and patch this kernel module.

Code is hosted on both GitHub and GitLab:
* https://gitlab.com/openvpn/ovpn-dco
* https://github.com/OpenVPN/ovpn-dco

Please refer to the README file for more details about how to build and
test ovpn-dco.
Patch submission can be done through this mailing list, as explained in
the README as well.

https://gitlab.com/openvpn/ovpn-dco/-/blob/master/README


The idea of implementing an OpenVPN kernel module has been around for
years; finally what were once words have become lines of code.
I hope more enthusiasts will join the project and help pushing the
development forward.

A big thanks goes to OpenVPN Inc. for having provided all required
resources to make this happen.


Looking forward to see patches coming through!
Happy hacking!


[1] https://www.openvpn.net
[2]
https://github.com/openvpn/openvpn3#building-the-openvpn-3-client-on-linux
[3] https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux

-- 
Antonio Quartulli
OpenVPN Inc.

