Message-ID: <45480C70.5080502@...41...>
Date: Tue, 31 Oct 2006 19:54:40 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <451FBC52.70900@...41...>
	<451FC16A.2010906@...795...>
In-Reply-To: <451FC16A.2010906@...795...>
Subject: [Openvpn-devel] OpenVPN Roadmap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: andrew@...795...
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>, 'openvpn-users' <openvpn-users@lists.sourceforge.net>


> James, do you have an informal road map for future OpenVPN development?
> There have been a number of major enhancements discussed and it's not
> clear how they would be brought together, or even if they fit under
> OpenVPN vs. a separate project. I'm wondering what your longer-term
> plans are for the project.

Yes, absolutely.  I've been mostly quiet on this list for a while, but 
I'm still focused on planning for future OpenVPN development.

OpenVPN 2.0.x
-------------

This branch is stable, and there are no plans to add new features.

OpenVPN 2.1
-----------

This branch is currently in the release candidate stage, and hopefully 
will be officially released within a month or so.  The major new 
features include:

    * topology subnet feature, allowing intuitive tun-based VPN subnets 
having 1 IP address per client.
    * TAP-Win32 adapter can now be opened from non-administrator mode.
    * PKCS #11 features for usage of cryptographic tokens ("smart cards").
    * ip-win32 adaptive feature, to improve Windows client connection 
reliability.
    * multihome feature to enable UDP-based multihoming of the server on 
multiple interfaces.
    * port-share feature to allow OpenVPN and an HTTPS server to share 
TCP port 443.


OpenVPN 2.2 or 2.5
------------------

This release will be open to patches which extend OpenVPN functionality 
without requiring a major rewrite of the core.  Features that fit into 
these constraints include allowing the OpenVPN server to listen on 
multiple TCP and UDP ports simultaneously or improving/merging 
additional IPv6 functionality.

There are a couple of useful new features already finished for OpenVPN 2.2:

* Added connection profiles feature.  See <connection>
  documentation in man page.

* Added --disconnect-while-inactive feature.  See
  man page.

Download via subversion:

  svn co https://svn.openvpn.net/projects/openvpn/branches/BETA22/openvpn

OpenVPN 3.0
-----------

While still out on the horizon, these are some of my ideas for OpenVPN 3:

* Refactor OpenVPN into a library (libovpn) which implements the 
low-level VPN functionality, and a wrapper which parses parameters and 
calls into libovpn to construct the actual VPN.

* Think of libovpn as evolving in the direction of a general-purpose 
userspace network stack, of which VPN will be a particular application.

* libovpn would be a complete user-space network stack API, providing 
objects that represent virtual NICs, network connections that tie local 
and remote virtual NICs together, security/cryptography attributes which 
can be assigned to objects, subclassable authentication objects, and a 
routing infrastructure.

* The goal of libovpn will be to provide a more flexible model for 
integrating different types of VPN functionality directly into 
applications.  Implementing this as a library gives us the benefit of 
high-level language bindings, so conceivably you could write your own 
VPN in python using the libovpn bindings, and it would still be 
efficient because most of the heavy lifting would be done by libovpn.

James


