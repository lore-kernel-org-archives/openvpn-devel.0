MIME-version: 1.0
Message-id: <0A8F79E22F384F3C9C2431348D66C11E@...139...>
From: Gisle Vanem <gvanem@...139...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
	<1302262805-23686-3-git-send-email-davids@...1347...>
Date: Fri, 08 Apr 2011 18:03:04 +0200
Subject: Re: [Openvpn-devel] [PATCH 2/2] Use %SystemRoot% instead of
 hard-codedC:\WINDOWS for temp directory path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

"David Sommerseth" <davids@...1347...> wrote:

> -  /* Try to use %TEMP% or %TMP% */
> -  tmpdir = getenv("TEMP");
> -  if( !tmpdir ) {
> -    tmpdir = getenv("TMP");
> +  CLEAR (tmpdir);
> +
> +  /* Try to use %TEMP%, %TMP% or %SystemRoot%\Temp */
> +  envptr = getenv("TEMP");
> +  if( envptr ) {
> +    return envptr;
>   }
> -  if( !tmpdir ) {
> -    /* Warn if we're using a hard coded path */
> -    msg (M_WARN, "Could not find %TEMP% or %TMP% environment variables.  "
> -         "Falling back to %s.  Consider to use --tmp-dir", DEFAULT_TMPDIR);
> -    tmpdir = DEFAULT_TMPDIR;

Why not a bit simpler; GetTempPath() (kernel32.dll) already does these tests. 
Ref: http://msdn.microsoft.com/en-us/library/aa364992(v=vs.85).aspx :

The GetTempPath function checks for the existence of environment 
variables in the following order and uses the first path found:
  1.. The path specified by the TMP environment variable.
  2.. The path specified by the TEMP environment variable.
  3.. The path specified by the USERPROFILE environment variable.
  4.. The Windows directory.

--gv

