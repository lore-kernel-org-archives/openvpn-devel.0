Message-ID: <4C77E4E8.4080505@...1114...>
Date: Fri, 27 Aug 2010 18:16:40 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1282918823.3789.0@...1207...>
In-Reply-To: <1282918823.3789.0@...1207...>
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/08/10 16:20, Karl O. Pinc wrote:
> On 08/27/2010 03:50:55 AM, David Sommerseth wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 09/04/09 19:44, Karl O. Pinc wrote:
>>>
>>> On 04/09/2009 07:58:46 AM, Karl O. Pinc wrote:
>>>>
>>>> On 04/09/2009 01:01:50 AM, Alon Bar-Lev wrote:
>>>>> On Thu, Apr 9, 2009 at 6:03 AM, Karl O. Pinc <kop@...1206...>
>> wrote:
>>>>>> It occurs to me that if I want to do more than
>>>>>> beg I should submit a patch, so one is attached.
>>
>> Sorry it has taken way too long time to get this one reviewed.  It's
>> just been quite a lot to do, and this was not considered critical
>> enough.
>>
>>> It occurs to me that it's no good having an unpackaged
>>> Windows binary archive without instructions regarding
>>> how to use it.
>>
>> Agreed!
> 
> So, is it worth doing any work at all on this?
> I have not had the time to add to the weekly irc meeting
> agenda and advocate live.  The arguments previously presented
> in email cover the subject already.

No problem!  I would say it makes sense to give some documentation how
to do this.  And you've already done a great job here!

>>> Attached is a patch to INSTALL-win32.html that
>>> documents how to make a custom Windows installer using
>>> the archive produced by my previous patch.
>>>
>>> I hope OpenVPN will consider these patches for inclusion.
>>
>> Review follows below.
>>
>>
>> - --- INSTALL-win32.html	2005-10-18 03:46:47.000000000 -0500
>> +++ INSTALL-win32.html.patched	2009-04-09 12:38:59.000000000
>> -0500
>>     ^^^^^^^^^^^^^^^^^^
>>
>> This is not a file which is available directly in the source tree.  
>> It
>> is in best case generated somehow.  How that is done, I have no idea
>> (I'm not using Windows platform for development).  However, there is 
>> a
>> INSTALL-win32.txt file - the patch should really be against that file
>> -
>> and without the HTML mark-ups.  Please do so against the git tree,
>> preferably the feat_misc or master branch.
> 
> The file _was_ in the source tree, but is no longer.  I will
> find the appropriate new file.

Thanks a lot!  I don't know how/when/why this changed, but that's
history.  But thanks for fixing it!

>> [...snip...]
>>
>> +<p>Note that an MS Windows machine is <em>not</em> a requirement.</
>> p>
>>
>> Why so? If I've understood you correctly, if having the needed 
>> windows
>> binaries available, you just rebuild the NSIS installer.  This should
>> be
>> possible to do also in Linux or *BSD.
> 
> We are in agreement here.  Did you miss the word "not" in the
> sentence or is there some other vagueness in the wording?

Ahh ... Sorry!   My mistake!  I somehow was blind of the "not".

>> [...snip...]
>>
>> +	<li>Nullsoft Install System<br />
>> +	<a
>> href="http://www.nullsoft.com/free/nsis/">http://www.nullsoft.com/
>> free/nsis/</a></li>
>>
>> This redirects to: http://nsis.sourceforge.net/Main_Page
> 
> Probably an a stale link.
> 
>>
>> [...snip...]
>>
>> +         <li>Unpack the OpenVPN unpackaged windows binaries.  The
>> +         result should be a directory, the unpacked OpenVPN binary
>> +         directory.  This directory should have subdirectories.</li>
>>
>> Confusing sentences ... a lot of unpacked unpacked binaries unpacked.
> 
> How about "Unpack the OpenVPN tar file.  The result ..."?

That's a lot better.  May I suggest:

   "Unpack the OpenVPN tar file.  The result should be in a
    directory, containing the OpenVPN the OpenVPN binary."

>> +
>> +         <li>Using Internet Explorer (TM) navigate to the
>> +         <code>nsi</code> subdirectory of the unpacked OpenVPN 
>> binary
>> +         directory.
>>
>> Using "Internet Explorer"?!?  Why not "Using the file browser ..."?
> 
> I don't know.  I'll look into it if we go farther.

Perfect!  It just sounded odd to use IE to browse the local files.  Of
course, it's probably a lot of IE mechanisms doing the job "under the hood".

>> [...snip...]
>>
>> +         <li> Add the 2 lines:<br /><code>File
>> +         "myserver.ovpn"</code><br /><code>File "ca.crt"</code><br /
>>>
>> +         to the <code>nsi/openvpn.nsi</code> file at the bottom of
>> +         the section titled: <code>Section "${P`'RODUCT_NAME}
>> Service"
>>                                                ^^^^^^^^^^^^^^^
>> Is this really correct?
> 
> Dunno.  At one point I tested everything.  This would include
> in the new installer those files, which are what's needed to 
> run a openvpn client that validates the server with a certificate.
> The point of the entire exercise being to create a single installer
> that contains everything needed to run openvpn.

Understood.  It was just the syntax with ${P`'RODUCT_NAME} which looked
very odd to me.  If it's correct, I won't object to that.

>> +         SecService</code></li>
>> +</ol>
>> +
>> +<p>Note that putting your configuration and CA certificate files 
>> into
>> +the <code>nsi</code> subdirectory is not the most organized 
>> approach.
>> +It is simply the easiest way to get started with NSIS.</p>
>>
>> What about to explain properly how to do it more organised?  Most
>> users
>> won't care, and when they learn the sloppy way - they will never
>> improve
>> it if it works.
> 
> There are probably multiple good ways to do the job.  I can see
> a quick mention of the options but past a certain point it's
> all theory.  I look at it this way; most users' won't read
> the instructions anyway.

But remember you have a community which do tell people to read the docs.
 At least, we do that pretty often on IRC.  And with forums beginning to
get some traction now, I'm sure this will be considered valuable
information!

>> Thank you once again for you patch and patience.  If we can have 
>> these
>> things straightened up, I'm able to pull it into the git tree.  As
>> this
>> patch do not touch any code, we can pretty sure get this on into the
>> 2.2
>> release.  We're about to send out a beta release pretty soon, but 
>> this
>> patch have the possibility to get accepted into a later beta release.
> 
> Unfortunately you caught me at a bad time and I won't be able to work
> on this for at least a couple of weeks and perhaps longer.
> It's waited this long.  May as well let it wait and be done right
> when it gets done.

No problem!  And we have time to wait for you - in fact, not being
willing to wait would be pretty rude considering it took me some months
to do this review :)  And if we miss the 2.2 release, it's always a 2.3
release.  But if we get something ready for the 2.2 release, I'm willing
to pull it in, even pretty late in the release cycle.

Thanks again for your feedback!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkx35KkACgkQDC186MBRfrrCwwCeODxswjDvmZGIJcSbhavkR3Xj
bTcAn2NorMZCczlgYoC1KjLtNx9O8ujq
=zvz3
-----END PGP SIGNATURE-----

