From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c64958$a0b7d630$1601a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <20060316183412.17912.qmail@...574...>
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
Date: Thu Mar 16 16:21:06 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

>-----Original Message-----
>From: openvpn-devel-admin@lists.sourceforge.net=20
>[mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Iftikhar
Qureshi
>Sent: Thursday, March 16, 2006 12:34 PM
>To: openvpn-devel@lists.sourceforge.net
>Subject: [Openvpn-devel] OpenVPN for PocketPC
>
>
>I was wondering what does it take to write an OpenVPN client/driver for=20
>PocketPC.
>
>I looked at the 'Porting Notes' section on the website. Still not sure=20
>what minimum modules I'll have to compile for PPC. If >any of you could=20
>guide me on what is involved.
>
>Once I have enough information I'll see if I got what it takes to write=20
>the client - otherwise - :)
>
>Salamz,
>-IQ


Iftikhar;

Funny you should mention that as I have been working on this for the past
two weeks.  Here is what I have found out along the way, and also what I
have done/am doing.

This will be a bit long, so let me tell the synopsis first; then anyone can
read the details later if they care.



Summary:

Built a port of the TAP driver first since that seemed the most
questionable.  I implemented the parts I thought might be show-stoppers, but
left incomplete for now some parts I know can be implemented for later,
after I have the user-mode stuff working to stimulate the driver.

Have been working for the past week on the user-mode side of things.  I have
just now been able to build it to completion, and can at least run the
--version and --help option successfully (whee).

Need to do:  testing of all the compatibility routines written, rework tun.c
to reflect different TAP interface, go back to TAP and complete
implementation of stuff I deferred.



OK, here is more detail:



TAP driver:

*  the existing win32 TAP driver is basically an NDIS miniport.  CE
(PocketPC underlying OS) supports much of the NDIS driver model, however
there is an extension to NDIS being used which is not available.  This
extension comes in the call NdisMRegisterDevice() which is used to create a
device object which the usermode app can open via CreateFile and do stuff
via ReadFile/WriteFile/DeviceIoControl.  Without it, usermode can't access
the device to provide the 'lower edge' functionality.  If you're curious,
this extension was apparently added to facilitate creating things like 1394
ethernet adapters.

I worked around this by also creating in the tap device a 'stream device' in
CE parlance.  It loads as a separate device driver (though implemented in
the same dll) and provides the common file IO through a device named 'TAP0'
(and higher digits).

*  the existing architecture in the win32 port depends on asynchronous IO,
or 'overlapped IO' as it is called.  CE, however, does not do overlapped IO
at all.  Couldn't manually implement it either, because the LPOVERLAPPED
passed into ReadFileEx is discarded and never makes it into the driver's
servicing routines.  I'm dealing with this now with an interim solution for
now, with a better solution later.

The short term solution I effected was to make the ReadFile call
fundamentally asynchronous returning with either:
  success, and a full packet read
  success, and 0 bytes read (meaning no packet available)
  failure, meaning there was a packet but the buffer was too small
  all other failure having the usual meanings
I did this because it was easy and I wanted to move on to other porting
activities since I can't do much testing without the user-mode interface or
a test harness built.  This is suboptimial since it is essentially a packet
polling interface, but it's temporary.

The long term solution I am planning is to ditch the ReadFile interface
altogether, and implement a custom asynchronous IO via an ioctl() interface.
This should have similar performance to the existing mechanism, and I think
can have a somewhat similar call sequence to the overlapped IO mechanism.
I'm concerned about the event handles, though, because unlike NT, the calls
aren't made in the process context of the calling process.  Rather threads
'migrate' from one process to another, and the device drivers are in a
different process called device.exe.  Weird!  So I wonder about the validity
of a handle created in one process and being passed-by-value to another.  It
might work but I think regardless it can be handled by having the events
brokered by the driver, and exposing a 'create', 'wait', and 'close' api to
be used with the custom asyncronous read.

*  There's also some more pedestrian aspects, like completely different
registry settings, and stuff involving IRQLs which are not relevant in CE.


Building CE TAP Driver:

*  I'm using eVC4 to build.  Drivers in CE are dlls, which personally I find
a bit nice.  There is not a DDK per se, but there is something similar in
the form of the Platform Builder, which is what OEMs use to create the OS
image for their devices.  There's headers and some import libraries in there
that are needed to link in the NDIS stuff since they aren't included in the
regular eVC install, alas.


State of CE TAP Code:

The code is a bit of a mess at present.  I hacked on it quite a bit while
trying stuff out.  I plan to clean it up to minimize diffs after I get it
finally working.



User-mode component:


The user-mode component is written in very nice portable C, however every OS
has it's peculiarities.  CE is highly peculiar.  In fact most of the past
couple weeks has been on the user-mode part, though not all of it openvpn,
but rather the dependencies.  Let me start with the dependencies because
this will save you discovery time in you're interested in trying to build or
work on that.  Oh wait, first let me describe configuration briefly:


Configuration:

I am building all the libraries as static libraries for now.  This makes it
easier for me for debugging.  I might create a dll-based configuration in
the end after all is said and done.

Targeting ARM and Emulator.  I do most of my initial development and testing
on the emulator.

For starters at least I am using the eVC project file mechanism (as opposed
to make files) except where noted.  I can produce make files in the end,
when all is said and done, but makefiles give me headaches.

Also, for now at least, I am building openvpn as-is, i.e. as a console
application.  Ultimately I would like to make a super-easy-to-use GUI
interface but figure that can wait until there's something working to
interface to.  As you know, PocketPC does not have a console, however.  So I
am using PocketConsole from SymbolicTools and the related PortSDK.  FWIW,
they don't seem to be developing it anymore, and it's not open source, but
it suffices for now I think.  Oh, and I don't think it works correctly on
VGA devices.


LZO library:

Easy.  Throw the source in a project and hit build and out comes a lib like
it should.  I'm a little surprised because I had to futz with UCL before to
get it to build, but I'll take it when I can get it.


OpenSSL library:

Spent more time on this one.  First, the latest release has official CE
support, which was definitely a time-saver.  There appears to be a defect in
the makefile spewed out for the emulator however and I had to manually edit
it to get it to work.  Before you get to that point though....

You have to download the PocketConsole, and some compatibility libraries you
will have to build.  The web page will tell you what you need and has links.

I should note that I had to edit the WCEemulator.bat that is normally
installed as part of eVC.  This batch file (and WCEARM.bat) are used to
setup the command-line environment when building stuff from nmake, which
will be happening for OpenSSL and it's dependencies.  Near the bottom is a
variable:

set TARGETCPU=3Demulator

Which I could not get to work, so I commented that out and changed it to

set TARGETCPU=3DX86EM

Which then did work.  Mostly.  Actually, one of the dependent libraries uses
that to build constructs a path based upon that variable (can't remember
which, I think wcecompatlib) and I had to edit it's mak file and I think
make a copy of a lib directory in the WCE Tools area.  I'll have to check
back later, but your compiler and linker will barf and let you know what's
not in order.  It's easy to fix once you're aware it's easy.

On to Open SSL.  You will need to install ActivePerl to run the perl scripts
that are part of the build.  The instructions given on the web page are
correct.  I built:

*  pocket console, static
*  compatlib, static
*  compatlib, dll

I'm only using the pocket console versions for current development because,
as I mentioned, I figured GUI stuff can be done later.

There is a couple gotchas:

*  at about line 58 of opensslconf.h (which is spewed out during
configuration) that the ENGINESDIR and OPENSSLDIR are set to things that are
appropriate for desktop systems.  In particular, there was a drive letter.
CE doesn't use drive letters.  I checked and made them the usual unix path
which should also be fine for CE.

#define ENGINESDIR "/usr/local/ssl/lib/engines"
#define OPENSSLDIR "/usr/local/ssl"

I don't know if it's critically important

*  the emulator build won't work.  The makefiles generated are almost
correct, but not quite.  You will have to edit them manually before you
invoke nmake.  In particular, you will need the following to read:

Around line 27
EX_LIBS=3D winsock.lib $(WCECOMPAT)/lib/wcecompatex.lib coredll.lib
corelibc.lib Around line 33 LFLAGS=3D/nologo /opt:ref
/subsystem:windowsce,4.20 /machine:IX86 /NODEFAULTLIB:libc.lib
/NODEFAULTLIB:oldnames.lib Around line 70 MLFLAGS=3D /nologo /opt:ref
/subsystem:windowsce,4.20 /machine:IX86 /dll /NODEFAULTLIB:libc.lib
/NODEFAULTLIB:oldnames.lib

Then they will go.  openSSL!  Hurray!

OK, then now you are ready to start working on the openVPN source.


I created a console app with the wizard in the PortSDK which generated a
hello world app.  Do it as an ANSI app.  The StdAfx.h that it generates has
three #includes which are important to include somewhere to get the console
stuff in, and the rest can be discarded.  I stuck them in config-win32.h
initially, but moved them later as described... ah...  later.  You will need
to modify that file to alter some of the config options.  I conditionally
compile with the definition:

#ifdef UNDER_CE

Which is the standard 'this is CE specific' #define.  It is already in your
project.  Also, you will need to define WIN32 which is _not_ standard on CE,
but seemed to be cleaner than hacking all the source files to modify the
tests.

You will need to modify=20
HAVE_CHDIR
HAVE_FCNTL_H
To not be defined, and
LZO_HEADER_DIR to be defined.  Well that actually depends.  I needed it.  It
affects wether you have an lzo subdirectory under your standard include with
the lzo stuff.  I happen to.


Near the bottome, where there is the #include <direct.h> is where I started
putting in my CE specific portability code.  It became large so I broke it
out in a separate file.  That region now reads:

//wild CE portability stuff
//HHH
#ifdef UNDER_CE
//additional api emulation and the like needed for win ce #include
"wince_portstuff.h" #else #include <direct.h> #endif


A modified very little of the rest of the source.  I had to modify
cryptoapi.c to #include "config-win32.h" to pick up the portability code,
which previously it had not.  I know I had to modify win32.c, which I
haven't finished I don't think, and misc.c had some environment stuff.  I'm
a little worried about that because CE does have environments, but hopfully
it won't matter.

As mentioned, the portability code became extensive enough that I broke it
out of the config-win32.h into a separate header, wince-portstuff.h.  There
is a matching wince-portstuff.c with implementation.

Oh, by the way, you won't need to include memcmp.c in your project.  Minor
detail.

At this point you will have a cornucopia of build errors and (eventually)
linker unresolved symbols.

Rather than going into details and making the email longer than usual, I'll
leave it to the asker to request the details of the stuff added to make it
build in link.  The short story is:

You will need to implement all the 'low-level c runtime' functions.  This
means things like open() read() write() stat() etc.  This is a chore.  I
hope my implementation works, it's going to be some debugging to prove it
though.  In short I faked low-level API as a warpper around the 'stream io'
calls like fopen, etc.  Happily those are present in CE.  I'm not sure about
my conversion of mode bits to the open mode string that fopen uses, though.
I'm a bit dubious in my implementation of open_osfhandle().  I'll leave out
the details here unless asked but there is a method _wfdopen() available
which is curious because it is defined as _taking_ a low-level handle, but
we know PocketPC doesn't have those (or we wouldn't have to be implementing
this stuff) so I /assume/ that really it takes an OS handle.  In which case
I can use it (since my fake low-level handles are really FILE*).  _fdopen is
a noop in this scheme.

More tedious is all the API stuff that needed changing.  It's a little like
porting NT to Windows95 because 95 doesn't have unicode functions.  Well,
this is the same thing but the opposite:  the openVPN is ANSI, but CE is
UNICODE only.  So a bunch of methods have to be wrapped with ANSI wrappers
and string translation done inside.  To complicate matters, the headers
define those ANSI functions, but they don't exist.  This means when you
implement them you will have a collision definition since the headers
declare them as declspec(import) which you will not be doing.  As a
work-around I did, for each, a version with the prefix CE_, and the
#undef'ed the api name and then #defined it to my new name.  Here is an
example of what I mean:


//DeleteFileA				//misc.c
BOOL WINAPI CE_DeleteFileA ( LPCSTR lpFileName );
#undef DeleteFile
#define DeleteFile CE_DeleteFileA

The following have to be treated in this manner:

FormatMessageA
CryptSignHashA
CreateFileA
DeleteFileA
RegQueryValueExA
RegEnumKeyExA
RegOpenKeyExA
CreateEventA
CreateSemaphoreA

Interesting exceptions are:

LoadLibraryA, which you can just implement directly without the trick above,
and

GetProcAddressA, which doesn't need the CE_ prefix hack, but curiously does
still the the #undef and #define because it is unconditionally #defined to
the wide-char version regardless of build flags.  Odd.


Lastly, you will need to stub GetOverlappedResult and CancelIo.  I didn't
bother implementing them because I know this stuff is not going to be
present with the CE TAP driver -- it will use a different mechanism (polling
initially, and funky asynchronous IO afterwards).


At this point, you should be able to build openVPN to completion.  It won't
actually work, obviously.  I just got to this point today, and only have
used the screen printing options --version and --help and a sanity
checkpoint.


Next steps:

*  test the portability functions I implemented in wince_portstuff.c to make
sure they really work.
*  study tun.c and figure out what has to be reworked there.
*  finish the 'deferred' activites in the TAP driver.
*  test fix test....

Later:

*  clean code for submission and regress
*  maybe alternative gui ui


And that's it for now.  Apologies for the length.  Actually it was helpful
to me to write it down as a log.

-Dave


