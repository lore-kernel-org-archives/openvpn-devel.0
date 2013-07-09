From: Josh Cepek <josh.cepek@...1085...>
Date: Tue, 09 Jul 2013 12:55:30 -0500
Message-ID: <krhiqc$cia$1@...1062...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Next-gen Easy-RSA development
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
To: openvpn-devel@lists.sourceforge.net

I've recently done a complete re-write of the Easy-RSA codebase and have 
a beta-release (currently beta-2) available at the following project 
homepage:

http://pekster.sdf.org/code/projects/easyrsa3.html

This beta is open for comment and suggestions. Still on the TODO list is 
integration for PKCS#11 support, including forward-porting an open 
github pull request for smartcard improvements from the 2.x project.

I wanted to get a beta released prior to smartcard support for general 
consumption and comment; I'm particularly interested in feedback from 
Windows users and use by batch-mode (non-interactive) callers of any 
platform.

The overall design goals are similar to the 2.x series including using a 
portable shell backend. A short improvements list can be found on the 
project page, but the two largest advantages include a simpler X.509 
Subject format that does away with the all the unnecessary location 
fields by default, and a unified codebase that runs the same shell code 
on Unix-alikes as well as Windows. Mandatory use of the 'vars' file is 
also done away with, making invocation and use easier for most common 
tasks, including use with OpenVPN.

--
Josh


