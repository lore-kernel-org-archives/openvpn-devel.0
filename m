References: <99D61A626FDA8A4B90A270669121BE109BE8AA4C@...2294...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <76addf9c-a14e-0e59-bb01-dace07b56a03@...277...>
Date: Thu, 20 Dec 2018 13:46:25 +0000
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109BE8AA4C@...2294...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [Help required] Testing MSI installations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 19/12/2018 21:55, Simon Rozman wrote:
> Hi,

> Remember: Test it to fail!
> 
> Any feedback kindly appreciated.
> 

I just tested this on a "fresh" Win7 VM and it failed.

By "fresh" I mean this:

   The Win7 VM is from:
   https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/

   Credit the find to:
   https://easylinuxtipsproject.blogspot.com/p/virtualbox.html

   The VM i used is IE11-Win7 x86


The error message reported is:
"There is a problem with this Windows Installer package.
A DLL required for this installer to complete could not be run.
Contact your support personnel or package vendor"
[OK]

Followed by
"The installer failed, your system has not been changed yadda .."

I notice the error message says "could not be run" not "not found"
Permissions ?
I logged in as local admin.
Openvpn 2.4.6 running from the GUI+interactive service at the time.



The %TEMP%/openvpn-install.log is:

=== Logging started: 20/12/2018  05:28:59 ===
Action 05:28:59: INSTALL.
Action start 05:28:59: INSTALL.
Action 05:28:59: SetDefaultUIFontVista.
Action start 05:28:59: SetDefaultUIFontVista.
Action ended 05:28:59: SetDefaultUIFontVista. Return value 1.
Action 05:28:59: SetDlgStrongFontVista.
Action start 05:28:59: SetDlgStrongFontVista.
Action ended 05:28:59: SetDlgStrongFontVista. Return value 1.
Action 05:28:59: SetDlgTitleFontVista.
Action start 05:28:59: SetDlgTitleFontVista.
Action ended 05:28:59: SetDlgTitleFontVista. Return value 1.
Action 05:28:59: PreparePage.
Action start 05:28:59: PreparePage.
Info 2898. For DefaultUIFontVista textstyle, the system created a 'Segoe 
UI' font, in 1 character set, of 20 pixels height.
Info 2898. For DlgTitleFontVista textstyle, the system created a 'Segoe 
UI' font, in 1 character set, of 25 pixels height.
Action 05:28:59: PreparePage. Dialog created
Action ended 05:28:59: PreparePage. Return value 1.
Action 05:28:59: FindRelatedProducts. Searching for related applications
Action start 05:28:59: FindRelatedProducts.
Action ended 05:28:59: FindRelatedProducts. Return value 1.
Action 05:28:59: FindTAPInterfaces. Searching for TAP interfaces
Action start 05:28:59: FindTAPInterfaces.
CustomAction FindTAPInterfaces returned actual error code 1154 (note 
this may not be 100% accurate if translation happened inside sandbox)


regards
richard

