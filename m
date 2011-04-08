Message-ID: <4D9F92AF.6040907@...1114...>
Date: Sat, 09 Apr 2011 00:56:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1302106222-10256-1-git-send-email-davids@...1347...>	<1302262805-23686-1-git-send-email-davids@...1347...>	<1302262805-23686-3-git-send-email-davids@...1347...>
	<0A8F79E22F384F3C9C2431348D66C11E@...139...>
In-Reply-To: <0A8F79E22F384F3C9C2431348D66C11E@...139...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gisle Vanem <gvanem@...139...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/04/11 18:03, Gisle Vanem wrote:
> "David Sommerseth" <davids@...1347...> wrote:
> 
>> -  /* Try to use %TEMP% or %TMP% */
>> -  tmpdir = getenv("TEMP");
>> -  if( !tmpdir ) {
>> -    tmpdir = getenv("TMP");
>> +  CLEAR (tmpdir);
>> +
>> +  /* Try to use %TEMP%, %TMP% or %SystemRoot%\Temp */
>> +  envptr = getenv("TEMP");
>> +  if( envptr ) {
>> +    return envptr;
>>   }
>> -  if( !tmpdir ) {
>> -    /* Warn if we're using a hard coded path */
>> -    msg (M_WARN, "Could not find %TEMP% or %TMP% environment variables.  "
>> -         "Falling back to %s.  Consider to use --tmp-dir", DEFAULT_TMPDIR);
>> -    tmpdir = DEFAULT_TMPDIR;
> 
> Why not a bit simpler; GetTempPath() (kernel32.dll) already does these tests. 
> Ref: http://msdn.microsoft.com/en-us/library/aa364992(v=vs.85).aspx :
> 
> The GetTempPath function checks for the existence of environment 
> variables in the following order and uses the first path found:
>   1.. The path specified by the TMP environment variable.
>   2.. The path specified by the TEMP environment variable.
>   3.. The path specified by the USERPROFILE environment variable.
>   4.. The Windows directory.

It's most probably very obvious that I'm not a Windows developer by now :)

I completely agree, the docs looks reasonable and we're also not supporting
Windows 2000 or older.  No need to reimplement core system features.

To avoid that I'm sending out yet another patch which will need to be fixed
again, can you please submit a proper patch for it?  I've never done
anything big on Windows with C before, so when it comes to specific Windows
API features, I'm completely blank.  For me the type LPTSTR tells me
nothing, I just presume it is some kind of Windows' equivalent of char *,
and that DWORD is some kind of 32 bit integer.  But I might be mistaken again.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2fkq0ACgkQDC186MBRfrqMaACeOLOGDHo8hVkz89Np+NOxkQLX
9W0AoIRYdC0SwpAiYqN2Zy4HS0v+dhBd
=bWuY
-----END PGP SIGNATURE-----

