Message-ID: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
Date: Sat, 14 Jan 2023 18:29:15 +0100
MIME-Version: 1.0
From: Arne Schwabe <arne@...1227...>
Content-Language: en-GB
Subject: [Openvpn-devel] Amend OpenVPN license to allow continued mbed TLS
 support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey,

This is the first round and will be only to the openvpn-devel list. 
After that I will also write to individuals email addresses but I want 
to start with sending this to the devel list.

We are writing to you since you are or were a contributor in past to 
OpenVPN and we would like to  ask for your permission to amend the 
license of OpenVPN.

OpenVPN 2.x is licensed under the GPL v2. This license has served us 
well in the past and we are not trying to change that. However, changes 
in licenses of our dependencies make this change necessary.

Both mbed TLS and OpenSSL nowadays use the Apache 2.x license. For the 
OpenSSL library we have a special exception that allows us linking with 
it. For newer mbed TLS version, we cannot do this any more. 
Compatibility of Apache 2.x and GPL 2.x has to our knowledge never been 
tested in court and even FSF and ASF disagree about the issue 
(https://www.apache.org/licenses/GPL-compatibility.html)

We would like to be able to continue to build/ship OpenVPN with mbed 
TLS. We want all contributors to ask if they agree to license change 
that adds explicit permission to link with Apache 2 licensed libraries:


Special exception for linking OpenVPN with Apache 2 licensed libraries:

   In addition, as a special exception, OpenVPN Inc and contributors
   give permission to link the code of this program to libraries with the
   "APACHE LICENSE, VERSION 2.0", and distribute linked combination
   including the two.  You must obey the GNU General Public License in
   all respects for all of the code used other than these libraries.  If
   you modify this file, you may extend this exception to your version of
   the file, but you are not obligated to do so.  If you do not wish to
   do so, delete this exception statement from your version.


You might wonder why we are going for a generic Apache 2 exception 
rather than one targeted at mbed TLS specifically. We believe that a 
generic exemption is better since it also implicitly allows forks of 
mbed TLS and even if a SSL library might emerge in the future we do not 
have to discuss if it is a fork or not. Also granting an explicit 
exception for Apache 2 style licenses reaffirms the linking to OpenSSL.

We also considered going for a change from GPL2 to GPL2+ but we think 
that GPL3 would hurt the ability to distribute OpenVPN as part of router 
or other embedded devices as the GPL3 has been explicitly developed (at 
least in part) to make this use case harder/impossible 
(https://en.wikipedia.org/wiki/Tivoization)

If you are okay with this, please reply to this mail and confirm that. 
Otherwise we might be forced to remove and/or rewrite your code.


As a reminder, the The current OpenSSL exception reads as follows 
(COPYING). We don't intend to change or remote it:

   Special exception for linking OpenVPN with OpenSSL:

   In addition, as a special exception, OpenVPN Inc gives
   permission to link the code of this program with the OpenSSL
   library (or with modified versions of OpenSSL that use the same
   license as OpenSSL), and distribute linked combinations including
   the two.  You must obey the GNU General Public License in all
   respects for all of the code used other than OpenSSL.  If you modify
   this file, you may extend this exception to your version of the
   file, but you are not obligated to do so.  If you do not wish to
   do so, delete this exception statement from your version.


