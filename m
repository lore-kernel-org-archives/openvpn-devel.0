Date: Fri, 18 Jun 2010 08:29:40 +0200
From: ma+ovpnd@...31...
Message-ID: <20100618062940.GA1130@...33...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to be
 username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Am 17.06.2010, 15:57 Uhr, schrieb Alon Bar-Lev:

> Great.
>
> Few more:
>
> 1. To upper:
> char *s = p[1];
> while ((*s = toupper(*s)) != '\0') s++;

I haven't looked at the patch yet, so my silence about anything else DOES  
NOT constitute approval or anything of the remainder of the code.

Picking out a random bit: toupper called on (unqualified) char without  
cast is A SECURITY RISK and NON-PORTABLE. It can cause BAD ARRAY SUBSCRIPT  
compiler warnings AND CRASHES (depending on if the compiler treats the  
char as signed or unsigned, which is implementation-dependent). Many libcs  
implement toupper via table lookup similar to:

static inline int isupper(int c) {
	return !!(ctypes[c+1] & _CUPPER);
}

EVERYBODY MUST ALWAYS cast toupper/tolower/to...() and is...() arguments  
to unsigned char:

char *s = ...
while ((*s = toupper((unsigned char)*s) != '\0') ++s;

Alternatively, declare unsigned char *s = ... - which will however cause  
signedness mismatches in assignments and thereabouts unless you cast.

That's because all these ctype.h functions take "int" arguments that can  
be EOF (-1) or any value representable as unsigned char. Check IEEE Std  
1003.1.



-- 
Matthias Andree

