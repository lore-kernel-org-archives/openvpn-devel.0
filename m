Message-ID: <4A0E54FB.6060407@...41...>
Date: Fri, 15 May 2009 23:54:03 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] ANNOUNCEMENT: OpenVPN Access Server beta available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVpn-Users <openvpn-users@lists.sourceforge.net>, Openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

As the founder of the OpenVPN project, I'm proud to announce the first 
beta release of our new product, the OpenVPN Access Server.

With this product, we've taken years of feedback from the OpenVPN 
community and condensed it into a lightweight but powerful management 
application that we believe will dramatically simplify the effort 
required to configure and manage OpenVPN, while still enabling its most 
powerful features.

It's been an interesting voyage for me, having started this project 7 
years ago.  At that time, "easy-to-use VPN" had a very different meaning 
that it does today.  "easy-to-use" meant that you could get it running 
without having to recompile your kernel :)

Over the years of developing and supporting OpenVPN, I've realized that 
getting VPNs to work right is hard -- sometimes even harder than writing 
the actual VPN code.

I think the complexity arises from the fact that VPN administration 
combines 3 different areas of expertise -- (1) Public Key Infrastructure 
(PKI) and certificate management, (2) IP Networking, including routing 
and firewall management, and (3) authentication models such as LDAP and 
RADIUS.

To me, there was always a dilemma of sorts in how to address this 
complexity.  Should OpenVPN stay true to the open source ideal of narrow 
focus and simplicity, where each tool should try to do a single job 
well, or should OpenVPN take the integrated approach and try to tackle 
all the issues that make VPNs complex, such as authentication, 
routing/firewall management, certificate management, etc?  The narrow 
focus ideal makes for a powerful tool, but the need for our community to 
master PKI, routing, authentication, etc. in order to deploy a 
real-world VPN solution created a lot of stumbling blocks on the path to 
enlightenment.  My openvpn-users inbox has over 26,500 messages since 
the project was launched back in 2002 -- it's a great testament to the 
strength of the community that has grown up around OpenVPN, but also a 
warning sign as well:  many of these messages are calls for help that 
cite different variations of the same stumbling blocks.

So my answer to the dilemma of lean-and-focussed, vs. 
integrated-and-easy-to-use is this:  We will take both paths.  On the 
open source front, we will continue to maintain and extend OpenVPN as a 
world-class VPN engine.  We will be releasing a brand new open source 
Windows client shortly as a part of the 2.1 release, and we remain 
committed to maintaining, supporting, and extending OpenVPN as an open 
source project.

On the other hand, we intend to use our commercial arm (OpenVPN 
Technologies) to really raise the bar on what is possible with VPN 
technology in general, and especially to take advanced features of 
OpenVPN such as PKI/certificate-management, LDAP/RADIUS authentication, 
gateway redirection, automated generation of Windows clients, etc. and 
make these features easily accessible to anyone who can operate a web 
browser.

So without further fanfare, I invite each of you to test drive the 
OpenVPN Access Server:

http://beta.openvpn.net/index.php/access-server/download-openvpn-as.html

Let us know how you like it, what works, and what doesn't work.  Our aim 
is to create a universal VPN management application that covers all the 
bases.  Current features include:

* Web-based management with integrated Admin UI.

* Fully automated certificate/PKI management.

* RADIUS, LDAP, and PAM authentication are all supported.

* VPN users can log in via a web interface to download a dynamically 
generated, plug-and-play Windows installer, or just a client 
configuration file to use with the OpenVPN client of their choice.

* We've developed a new Windows client from scratch that uses the 
OpenVPN Management interface, and we plan to open source this component 
for the upcoming OpenVPN 2.1 release.

* The Access Server is just a front-end around the standard open source 
OpenVPN daemon, and all control occurs over the OpenVPN management 
interface.

* The Access Server is compatible with any OpenVPN 2.1 client.

* While the Access Server is a commercial product, and not open source, 
we will be open sourcing components of the product such as the new 
Windows client, and of course revenue from the product will help to 
sustain development and support of the OpenVPN core.

* The Access Server will be free for up to 2 concurrent connections, and 
inexpensive licenses will be available for additional concurrent 
connections (we're looking at pricing of $5/concurrent client which 
includes 1 year of access to our support center and software updates).

Below are the Release Notes for this release.  We hope you try out
the OpenVPN Access Server v1.1.0 and we look forward to receiving
your feedback.

Currently, we support the following Linux platforms for the Access 
Server.  We are in the process of expanding this list and will be 
supporting CentOS shortly:

   * 64-bit Fedora 8, 9, 10
   * 64-bit Ubuntu 8, 9


------------------------------------------------------------------
            OpenVPN Access Server v1.1.0b2 (beta 2)
                        RELEASE NOTES

Feedback and Support:
--------------------
We appreciate your feedback on this release. Register and login
at the Support Center to use the support ticketing system:

   http://beta.openvpn.net/index.php/access-server/support-center.html


New in Access Server v1.1.0:
---------------------------

Below are the main enhancements added since the Access Server v1.0.0
release:

-- Admin Web UI for configuration and management, including improved
    configuration options

-- Simplified CLI utility (ovpn-init) for initial configuration

-- Multi-profile support on Windows Client GUI

-- New method of authenticating via LDAP with enhanced configurability


Changes Since Access Server v1.1.0b:
-----------------------------------

The Access Server v1.1.0b2 contains these improvements since the
v1.1.0b release:

-- Better interoperation with installed OpenVPN open-source clients
    (installer no longer removes all TAP interfaces)

-- Corrected version numbering of the Windows Client, so that it
    properly detects an installed OpenVPN-AS v1.0.0 client.

-- Fix for an issue occasionally seen on Windows Client GUI where
    the TAP adapter cannot get an IP address due to a problem in DHCP
    handshaking between the TAP adapter and the Windows DHCP client.

-- Fix for an iptables issue that caused NAT forwarding to fail.


Installation:
------------

After installing the OpenVPN-AS package (e.g., using 'yum' on Fedora
platforms), run the initialization script:

/usr/local/openvpn_as/bin/ovpn-init

You will be prompted for initial settings for the Admin Web UI networking
and for authenticating the administrator. When ovpn-init completes, it
displays the URL to use for logging into the Admin Web UI to continue
configuring OpenVPN-AS.


License Keys:
------------

You can use the Admin UI after ovpn-init completes. However, to turn on
the VPN Server component of OpenVPN-AS, you must have an activated
license key. To get started, you can obtain a free, 5-concurrent-user
license by registering and logging in at the License Key page:

   http://beta.openvpn.net/index.php/access-server/license-key.html

Enter the license key into the "New License Key" box of the "License"
page in the Admin Web UI.


Known Issues:
------------

-- Accessing the Client Web Server without an activated license key
    yields an error message "error communicating with server agent".

-- Windows Client status display may remain at "Connecting TCP..."
    or "Connecting UDP..." when communication with VPN server fails.

-- Occasionally, when the Windows Client GUI attempts to connect to
    the VPN Server for the first time, the connection may stall at
    the "Connecting" stage and not complete.

-- Administrators should ensure that the VPN Server is not configured
    to run on the same (IP Address:port) combination as the Client Web
    Server or Admin UI.  Currently, the Admin UI does not flag this
    condition with an error, though it is an invalid configuration.

-- The PAM authentication module uses the 'sshd' PAM service, so the
    /etc/pam.d/sshd file must exist and be properly configured for
    user authentication.

-- The Ubuntu package does not configure the system so that the
    openvpnas service starts during system startup.


Best Regards,
James Yonan & the OpenVPN Technologies Team

