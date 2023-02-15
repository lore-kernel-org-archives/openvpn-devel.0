Message-ID: <9160f6a3-1a61-d112-7a48-a7da4af38644@...2108...>
Date: Wed, 15 Feb 2023 13:31:02 +0100
MIME-Version: 1.0
Content-Language: en-US
From: David Sommerseth <dazo+openvpn@...2108...>
Subject: [Openvpn-devel] OpenVPN Linking Exception
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>


OpenVPN 2.x is licensed under the GNU Public License v2.0 (GPL-2.0). 
This license has served us well in the past and we are not trying to 
change that.  However, changes in licenses of our dependencies put us in 
an unfortunate situation.

Both mbed TLS and OpenSSL nowadays use the Apache 2.x license (APL-2). 
For the OpenSSL library we have a special exception that allows us 
linking with it.  For newer mbed TLS versions, we cannot do this any more.

The APL-2 allows very liberal use of its source code when including it 
in other program (like BSD license).  Unlike BSD licenses, the APL-2 has 
a few additions that position it better in today's legal landscape.  It 
requires patent grant (in layman terms: you cannot contribute to an 
APL-2 licensed project and later sue someone for using your patents on 
the code you contributed).  This is the most critical aspect where the 
APL-2 is incompatible with GPL-2.0 according to Free Software Foundation 
- <https://www.gnu.org/licenses/license-list.html#apache2>.

A short overview of APL-2 and license text can be found here:
<https://tldrlegal.com/license/apache-license-2.0-(apache-2.0)#summary>

The OpenVPN community has discussed these issues with Pamela Chestek
<https://www.chesteklegal.com/> on the linking exception.  She is a 
renowned open source license legal expert.  Various options for this 
challenge have been studied and evaluated.

What is clear is that we will need a linking exception.  The OpenSSL and
mbed TLS libraries may be considered system libraries on Linux systems 
but cannot be considered as such for distributions of the OpenVPN binary 
on Windows, macOS or Android.


The proposed linking exception for OpenVPN:

     In addition, as a special exception, OpenVPN Inc and the
     contributors give permission to link the code of this program to
     libraries (the "Libraries") licensed under the Apache License
     version 2.0 (this work and any linked library the "Combined Work")
     and copy and distribute the Combined Work without an obligation to
     license the Libraries under the GNU General Public License v2
     (GPL-2.0) as required by Section 2 of the GPL-2.0, and without an
     obligation to refrain from imposing any additional restrictions in
     the Apache License version 2 that are not in the GPL-2.0, as
     required by Section 6 of the GPL-2.0.  You must comply with the
     GPL-2.0 in all other respects for the Combined Work, including
     the obligation to provide source code.  If you modify this file, you
     may extend this exception to your version of the file, but you are
     not obligated to do so.  If you do not wish to do so, delete this
     exception statement from your version.

This exception is the verbatim copy from Pamela Chestek, and the content
in this copy above has been reviewed by her.  There is some legalese
phrases there (in particular related to "Combined work") which may seem 
odd, but this is common practice in legal definitions.

In plain non-legalese English this basically says:

  * The intention for this license exception is to allow OpenVPN to be
    linked against APL-2 licensed libraries, even where the GPL-2.0 and
    APL-2 licenses conflict from a legal perspective.

  * OpenVPN itself will stay GPL-2.0 and the code belonging to the
    OpenVPN project must comply to the GPL-2.0 license.  This is NOT
    dual-licensing of the OpenVPN code base.

  * This license exception DOES NOT require NOR expect a license change
    of the APL-2 based library.  This exception allows using the APL-2
    library as-is.  However, when distributing a compiled OpenVPN binary
    linking against APL-2 libraries ("Combined Work"), the REQUIREMENT is
    that the APL-2 library MUST also be available on similar terms as in
    GPL-2.0, like providing the source code of the library upon request,
    except in the two specific ways mentioned.

  * If the APL-2 based library forbids such linking and distribution,
    this license exception DOES NOT overrule the restriction of the APL-2
    based library.  If the APL-2 library cannot satisfy the requirements
    in this license exception, you CANNOT distribute an OpenVPN binary
    linked with this library.


I hope we can reach an agreement and replace the current OpenSSL linking 
exception with this new exception above.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


