From: Arne Schwabe <arne@...1227...>
Message-ID: <68942d9b-6eca-9d1e-ad79-e8a9e6b28c39@...1227...>
Date: Fri, 26 Feb 2021 11:27:24 +0100
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] OpenVPN 2 support data channel offloading
 (ovpn-dco) alpha release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey,

I am proud to announce OpenVPN with data channel offloading support.
This bases on Antonio's great work with ovpn-dco kernel module that
implements forwarding/encrypting/decrypting VPN packets in kernel space.

A detailed description is available under
https://github.com/schwabe/openvpn/blob/dco/README.dco.md

Here are some quick performance numbers. Keep in mind that these are in
an uncontrolled development environment and should only give a rough
idea and can also still improve. Two VMs running Ubuntu 20.04 and 20.10
running under Hyper-V on an AMD TR3970 and using a simple iperf -s on
one side and iperf -c on the other side. OpenVPN was running in p2p
mode on both VMs in all tests but a normal client/server setup results
in the same performance numbers.

- Raw performance              13.2 GBit/s
- GRE Tunnel 		        5.5 GBit/s
- ovpn-dco (AES-256-GCM)        4.0 GBit/s
- ovpn-dco (AES-128-GCM)        4.0 GBit/s
- ovpn-dco (Chacha20-Poly1305)  2.7 GBit/s
- openvpn without dco           0.5 GBit/s
- client dco, server no dco     1.8 GBit/s (*1)
- client no dco, server dco     0.5 GBit/s (*2)

For comparison openssl speed -evp cipher results are 2.2 GB/s (17.6
GBit/s)for Chacha with 1024 bytes and 4.0 GB/s (32 GBit/s) for
AES-256-GCM with 1024 bytes.

There is one interesting result in this quick test, which is the number
marked with *1. In this test the client sends the data. It looks like
our send path in openvpn 2.x is a lot more optimised than our receive
path (*2).

We would like to invite everyone to test/play with OpenVPN + ovpn-dco
and would happy to hear about your experiences and results (and also of
course bug reports/suggestions).

Arne

