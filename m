From: Simon Rozman <simon@...2293...>
Date: Wed, 19 Jun 2019 13:27:32 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10ABCB10D8@...2294...>
References: <611691a5-e91c-c292-93f0-d70b40e35e03@...515...>
In-Reply-To: <611691a5-e91c-c292-93f0-d70b40e35e03@...515...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_009D_01D526B3.8319B840"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Remaining tap-windows6 HLK test failures
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-2?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_009D_01D526B3.8319B840
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Hi,

> Static Tools Logo Test
> 
>   Test description:
> <https://docs.microsoft.com/en-us/windows-
> hardware/test/hlk/testref/6ab6df93-423c-4af6-ad48-8ea1049155ae>
> 
>   Subtest: Run Test -> DevfundTests.DvlTest.DvlCheck
> 
>   Error: DVL test failed:
>          Microsoft.StaticToolsLogo.ObjectModel.DvlException:
>          C:\dvl: the folder does not exist.
>          at Microsoft.StaticToolsLogo.ObjectModel.DvlChecker.CheckDvl()
>          at DevfundTests.DvlTest.DvlCheck()
>   Error Type:
>   Error Code:   0x0
>   Error Text:   Error 0x00000000

Here's the recipe for this...

Apply this:

diff --git a/src/tap-windows6.vcxproj.in b/src/tap-windows6.vcxproj.in
index f60f30a..9afb4c5 100644
--- a/src/tap-windows6.vcxproj.in
+++ b/src/tap-windows6.vcxproj.in
@@ -152,6 +152,8 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <DebuggerFlavor>DbgengKernelDebugger</DebuggerFlavor>
     <TargetName>@PRODUCT_TAP_WIN_COMPONENT_ID@</TargetName>
+    <RunCodeAnalysis>true</RunCodeAnalysis>
+
<CodeAnalysisRuleSet>$(WDKContentRoot)CodeAnalysis\DriverMinimumRules.rulese
t</CodeAnalysisRuleSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <DebuggerFlavor>DbgengKernelDebugger</DebuggerFlavor>
@@ -171,6 +173,7 @@
 
<DisableSpecificWarnings>%(DisableSpecificWarnings);4201;4214;4100;4101;4200
;4057;4127</DisableSpecificWarnings>
       <TreatWarningAsError>false</TreatWarningAsError>
 
<PreprocessorDefinitions>%(PreprocessorDefinitions);TAP_DRIVER_MAJOR_VERSION
=@PRODUCT_TAP_WIN_MAJOR@;TAP_DRIVER_MINOR_VERSION=@PRODUCT_TAP_WIN_MINOR@;ND
IS_WDM=1;NDIS_MINIPORT_DRIVER=1;NDIS620_MINIPORT=1;NDIS630_MINIPORT=1</Prepr
ocessorDefinitions>
+      <EnablePREfast
Condition="'$(Configuration)|$(Platform)'=='Release|x64'">true</EnablePREfas
t>
     </ClCompile>
     <Link>
 
<AdditionalDependencies>%(AdditionalDependencies);$(KernelBufferOverflowLib)
;$(DDK_LIB_PATH)ntoskrnl.lib;$(DDK_LIB_PATH)hal.lib;$(DDK_LIB_PATH)wmilib.li
b;ndis.lib;ntstrsafe.lib;wdmsec.lib</AdditionalDependencies>

This will enable code analysis on Release|x64 builds. DVL will need the
tap-windows6\src\x64\Release\vc.nativecodeanalysis.all.xml file too.

Run:

buildtap.py -b

...to make the tap-windows6.vcxproj.

Run:
msbuild.exe tap-windows6.vcxproj /p:Configuration=Release /p:Platform=x64
/t:SDV /p:Inputs=/check:*

Note: Current directory must be the same where the tap-windows6.vcxproj file
is located (tap-windows6\src), or else you will get a cryptic error MSB3073:
The command "staticdv /check:*" exited with code -1.

This will take about half an hour to make a Static Driver Verifier report.
It will report 3 issues with current tap-windows6 master.

Next, run:
msbuild.exe tap-windows6.vcxproj /p:Configuration=Release /p:Platform=x64
/t:DVL

It will make a Driver Verification Log in tap0901.DVL.XML.

(Above should be integrated in buildtap.py.)

Now, deploy the tap0901.DVL.XML to C:\dvl\tap0901.DVL.XML (mind the path) on
each test computer. Or at least one test computer but select that
device/computer specifically when scheduling the Static Tools Logo Test to
run.

https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/6ab6df93-
423c-4af6-ad48-8ea1049155ae says WHLK is fine with failed SDV tests. It just
needs the DVL report. Microsoft wants to make sure you are running the code
analysis and are aware your driver has issues.

Best regards,
Simon


------=_NextPart_000_009D_01D526B3.8319B840
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwMwJzAlBggrBgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzAIBgYEAIswAQIwGAYI
KwYBBQUHAQMEDDAKMAgGBgQAjkYBATAaBgNVHREEEzARgQ9zaW1vbkByb3ptYW4uc2kwge4GA1Ud
HwSB5jCB4zBWoFSgUqRQME4xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlv
bnMxETAPBgNVBAsTCHNpZ2VuLWNhMQ8wDQYDVQQDEwZDUkw0NTUwgYiggYWggYKGV2xkYXA6Ly94
NTAwLmdvdi5zaS9vdT1zaWdlbi1jYSxvPXN0YXRlLWluc3RpdHV0aW9ucyxjPXNpP2NlcnRpZmlj
YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYYnaHR0cDovL3d3dy5zaWdlbi1jYS5zaS9jcmwvc2lnZW4t
Y2EuY3JsMCsGA1UdEAQkMCKADzIwMTYwMjE5MTc1NDQxWoEPMjAyMTAyMTkyMTM4MTVaMB8GA1Ud
IwQYMBaAFHF7igYfMQVVq2ASd0cgHgOIGOyJMB0GA1UdDgQWBBS7/7AHyQYI0e8GOPmwTc1ZTNw5
lzAJBgNVHRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjEDAgOoMA0GCSqGSIb3DQEBBQUAA4IB
AQBBUL4KG1Z1oBIIdKIZs9yJxnJg/LfEPVvzNH8+CCqegq0D6k48Doo72oVEiskjqggdbUGj30uA
H8PjCD5kLGVoDwh5a2atQ3qQzaYA/lj2Js2f4fdXNn60vRp7XzbGsQdwYYecIrKzO5x6XVAIRb+T
HZNjXL3VX6vOozwBQv/+dx1P9H/rMUn7d8ci7v4PeqShbWbWwi6ez19cZvSKSkz/lWf4tj8QbA0n
WeUBlk3Bx6/TRda7kwXzcFExt+ROGt0YJjbZCN3kd7swcRvRT6gEi9L6n1XLghwPSYhzZjaL5fXv
I11JuSoQCy13XWBkq35Moo4iY19wanS1W6UM8Yq0MIIF5TCCBE2gAwIBAgINAKZovVEAAAAAVx3Q
6DANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3Zl
bmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QwHhcN
MTYwNTI0MTE1ODI3WhcNMjEwNjI3MjIwMDAwWjA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3Rh
dGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALDlZbLArGSW8ogbs+2e5ALGTyuIzi6KUYB1rxBb8ss4ZpuiDm00R5alkhGv9jVH
onciDM4WiGKq00luGLwuRNi+xp7CGhmsQY78MAcC8sZq1FsjAO9BNNikc2PfIpIzhAGljfODXPq4
1Ho13+z4bQ/gTO2tnDp9htalCJS+fXoRH/6FP1RaiGOHnKWxp07Nt0Rzr8+KSWsf483XSU1aKxfm
XHazu3K5byfSm4kViN8QX3YhAWrHFTEK0ZxY+CgWBW3ZTtmh1wcgy0smiU2Ssqe6lujjWI8inAGW
WsT3MU0LSbXheGHiVBgGu55UNH4MPuvutYAf3RaEHWg4Zmdz+JECAwEAAaOCAkMwggI/MBIGA1Ud
EwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEwLwYEVR0gADAnMCUGCCsG
AQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUFBwEBBF0wWzA2BggrBgEF
BQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJvb3QuY3J0MCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwHQYDVR0OBBYEFHF7igYfMQVVq2ASd0cgHgOIGOyJ
MIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9zaS10
cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qsb3Jn
YW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zlbmlq
YSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJTSTEc
MBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAU
BgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4IAmMw
DQYJKoZIhvcNAQELBQADggGBAHuvNSPhY4qcirWJkTwkqaOPqOSV06J/ZepFQfUEJ87TlrGjp4XR
5FLktTAEY/7R4Sgeb2K8OWEl/Koc1BbH6+uyZYvfa+WnnJEWeWOmyPy/vooO7eZyOVvaORxurWOL
CCVDW2wBkbtUoKZaUyzgP+ZPPGRV8GFlbZLCzGmArMGXJXe8t/XNiJDLehGqSWT49NYjyYQdIgI+
qi9W+A6BSUQ9jsMdYJqKhXQcosfH51sc6gZVxTKMr3PsItsa8XFiNazECAAFr0ms7HB6zb8QvHRF
eBGk/CLrW4VkZEBN/JtuyhvgktQ2BvuGtauEvHZQAYpMSh35D7pwtavRMpmhaAsQb4yPqhIMcztw
RqsKPBhWoaFEVZ+Vn3wxap5h/oAhocifNzkWJTNWjxnoPM2eNz2uWFJsgsNhlwteUvnq7+bKTNte
SKWKr6pI+GUsZhmCh5URpUnqUanp0Uie0MD9f3tiOLOp711sNb0xwi+VdDuDB37IddOIsfhPBood
wpoFrTGCAyEwggMdAgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggGtMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDYxOTEzMjczMVowLwYJKoZIhvcN
AQkEMSIEIPQ0mWMcm5qmsxHZRYXVQOzwUuQPwYVhWZ2zWhlHFbC5MFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAOr9IqQbeX4rj4jEoZPMb/pg
lt0UmHgITzVPo/6pS6KOKg4DoypEnBzBrr2DFsnb/l4prKCD7TEFuJj5yCLfnKZBbN9RU011mjKs
KQdrS38h2r4D+lD8Sn1lZ4eBbe7sBcZUxtYvSIA30xO8OQZDTp7N6y8qqco/8YoczT0LH1fq9wdh
vjuGznJ6StnwMYjjthQn94G9DnQ7RBf+ZCGm/5iykcys70ityFeBrlw3sBuPVxE0oZ1n2ygAxIF/
ALlW+Bg8R1GMN0qKMS2G564WhCzSbRGBos3dF1O6qgcCViX3+SUKmWn6ijI/KZLMnDd1RJAxgCaU
GFPV1hAScYuse14AAAAAAAA=

------=_NextPart_000_009D_01D526B3.8319B840--

