From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Fwd: openvpn config parsing
In-Reply-To: <pan.2004.12.22.10.21.55.867168@...294...>
Message-ID: <Pine.LNX.4.58.0412220435340.7923@...41...>
References: <20041222100009.GE1926@...30...> <pan.2004.12.22.10.21.55.867168@...294...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Dec 22 04:12:05 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Charles Duffy <cduffy@...294...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 22 Dec 2004, Charles Duffy wrote:

> On Wed, 22 Dec 2004 11:00:09 +0100, Alberto Gonzalez Iniesta wrote:
> > Recent updates of openvpn appear to have changed the handling of
> > whitespace in tls certificate names.
>   ...
> > Now it needs '_' not '.' for spaces:
> 
> My guess is that this is a consequence of some string-handling changes
> that were going on around 2.0-beta12 to 2.0-beta15.

Yes, this is something that needs to be better documented.  Prior to
2.0-beta12, the string remapping code was a bit ad-hoc.  Since then I've
tried to unify all string remapping towards a consistent model which
remaps illegal chars to '_'.  The choice of underbar is arbitrary -- any
inert character will do.

Here is a brief rundown of OpenVPN's current string types and the 
permitted character class for each string:

X509 Names: Alphanumeric, underbar ('_'), dash ('-'), dot ('.'), at 
('@'), colon (':'), slash ('/'), and equal ('=').  Alphanumeric is defined 
as a character which will cause the C library isalnum() function to return 
true.

Common Names: Alphanumeric, underbar ('_'), dash ('-'), dot ('.'), and at                
('@').

--auth-user-pass username: Same as Common Name.

--auth-user-pass password: Any "printable" character except CR or LF.  
Printable is defined to be a character which will cause the C library 
isprint() function to return true.

--client-config-dir filename as derived from common name or username: 
Alphanumeric, underbar ('_'), dash ('-'), and dot ('.') except for "." or 
".." as standalone strings.

Environmental variable names: Alphanumeric or underbar ('_').

Environmental variable values: Any printable character.

For all cases, characters in a string which are not members of the legal 
character class for that string type will be remapped to underbar ('_').

Q: Why is string remapping necessary?

A: It's an important security feature to prevent the malicious coding of
strings from untrusted sources to be passed as parameters to scripts,
saved in the environment, used as a common name, translated to a filename,
etc.

James

