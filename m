From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Nov 2023 12:04:30 +0100
Message-Id: <20231121110430.16893-1-frank@...2641...>
In-Reply-To: <20231121101139.13656-1-frank@...2641...>
References: <20231121101139.13656-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] sample-keys: renew for the next 10 years
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Old expiration was October 2024, less than a year away.
Give everyone the chance to get the new keys before tests
start failing.

Change-Id: Ie264ec1ec61fd71e8cc87987be3e2adc2735c201
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 sample/sample-config-files/loopback-client | 319 +++++++++++----------
 sample/sample-keys/ca.crt                  |  67 ++---
 sample/sample-keys/ca.key                  | 100 +++----
 sample/sample-keys/client-ec.crt           | 135 ++++-----
 sample/sample-keys/client-ec.key           |   6 +-
 sample/sample-keys/client-pass.key         |  60 ++--
 sample/sample-keys/client.crt              | 162 +++++------
 sample/sample-keys/client.key              |  52 ++--
 sample/sample-keys/client.p12              | Bin 4533 -> 4707 bytes
 sample/sample-keys/dh2048.pem              |  12 +-
 sample/sample-keys/gen-sample-keys.sh      |   3 +-
 sample/sample-keys/server-ec.crt           | 146 +++++-----
 sample/sample-keys/server-ec.key           |   6 +-
 sample/sample-keys/server.crt              | 170 +++++------
 sample/sample-keys/server.key              |  52 ++--
 sample/sample-keys/ta.key                  |  32 +--
 16 files changed, 663 insertions(+), 659 deletions(-)

Resend patch with binary diff.

diff --git a/sample/sample-config-files/loopback-client b/sample/sample-config-files/loopback-client
index 8ac3d1d7..76157eb8 100644
--- a/sample/sample-config-files/loopback-client
+++ b/sample/sample-config-files/loopback-client
@@ -24,70 +24,71 @@ remote-cert-tls server
 #ca sample-keys/ca.crt
 <ca>
 -----BEGIN CERTIFICATE-----
-MIIGKDCCBBCgAwIBAgIJAKFO3vqQ8q6BMA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV
-BAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMM
-T3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4w
-HhcNMTQxMDIyMjE1OTUyWhcNMjQxMDE5MjE1OTUyWjBmMQswCQYDVQQGEwJLRzEL
-MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMIICIjANBgkq
-hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsJVPCqt3vtoDW2U0DII1QIh2Qs0dqh88
-8nivxAIm2LTq93e9fJhsq3P/UVYAYSeCIrekXypR0EQgSgcNTvGBMe20BoHO5yvb
-GjKPmjfLj6XRotCOGy8EDl/hLgRY9efiA8wsVfuvF2q/FblyJQPR/gPiDtTmUiqF
-qXa7AJmMrqFsnWppOuGd7Qc6aTsae4TF1e/gUTCTraa7NeHowDaKhdyFmEEnCYR5
-CeUsx2JlFWAH8PCrxBpHYbmGyvS0kH3+rQkaSM/Pzc2bS4ayHaOYRK5XsGq8XiNG
-KTTLnSaCdPeHsI+3xMHmEh+u5Og2DFGgvyD22gde6W2ezvEKCUDrzR7bsnYqqyUy
-n7LxnkPXGyvR52T06G8KzLKQRmDlPIXhzKMO07qkHmIonXTdF7YI1azwHpAtN4dS
-rUe1bvjiTSoEsQPfOAyvD0RMK/CBfgEZUzAB50e/IlbZ84c0DJfUMOm4xCyft1HF
-YpYeyCf5dxoIjweCPOoP426+aTXM7kqq0ieIr6YxnKV6OGGLKEY+VNZh1DS7enqV
-HP5i8eimyuUYPoQhbK9xtDGMgghnc6Hn8BldPMcvz98HdTEH4rBfA3yNuCxLSNow
-4jJuLjNXh2QeiUtWtkXja7ec+P7VqKTduJoRaX7cs+8E3ImigiRnvmK+npk7Nt1y
-YE9hBRhSoLsCAwEAAaOB2DCB1TAdBgNVHQ4EFgQUK0DlyX319JY46S/jL9lAZMmO
-BZswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJ
-BgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UE
-ChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h
-aW6CCQChTt76kPKugTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG
-9w0BAQsFAAOCAgEABc77f4C4P8fIS+V8qCJmVNSDU44UZBc+D+J6ZTgW8JeOHUIj
-Bh++XDg3gwat7pIWQ8AU5R7h+fpBI9n3dadyIsMHGwSogHY9Gw7di2RVtSFajEth
-rvrq0JbzpwoYedMh84sJ2qI/DGKW9/Is9+O52fR+3z3dY3gNRDPQ5675BQ5CQW9I
-AJgLOqzD8Q0qrXYi7HaEqzNx6p7RDTuhFgvTd+vS5d5+28Z5fm2umnq+GKHF8W5P
-ylp2Js119FTVO7brusAMKPe5emc7tC2ov8OFFemQvfHR41PLryap2VD81IOgmt/J
-kX/j/y5KGux5HZ3lxXqdJbKcAq4NKYQT0mCkRD4l6szaCEJ+k0SiM9DdTcBDefhR
-9q+pCOyMh7d8QjQ1075mF7T+PGkZQUW1DUjEfrZhICnKgq+iEoUmM0Ee5WtRqcnu
-5BTGQ2mSfc6rV+Vr+eYXqcg7Nxb3vFXYSTod1UhefonVqwdmyJ2sC79zp36Tbo2+
-65NW2WJK7KzPUyOJU0U9bcu0utvDOvGWmG+aHbymJgcoFzvZmlXqMXn97pSFn4jV
-y3SLRgJXOw1QLXL2Y5abcuoBVr4gCOxxk2vBeVxOMRXNqSWZOFIF1bu/PxuDA+Sa
-hEi44aHbPXt9opdssz/hdGfd8Wo7vEJrbg7c6zR6C/Akav1Rzy9oohIdgOw=
+MIIGPjCCBCagAwIBAgIUb1C400ZucjRZvAAz3XyuEusnRgYwDQYJKoZIhvcNAQEL
+BQAwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgMAk5BMRAwDgYDVQQHDAdCSVNIS0VL
+MRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEWEm1lQG15aG9z
+dC5teWRvbWFpbjAeFw0yMzExMDcxMjIzMzlaFw0zMzExMDQxMjIzMzlaMGYxCzAJ
+BgNVBAYTAktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UE
+CgwMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h
+aW4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCI+p/ZLGUHCANTTFaK
+nw+J3wi+ef2EKJ5WHt5PWMuBeaDpeU4Ghuaow8HlRPjG9lDRHtn+WQgZz9nUejYH
++wtmN2BHwJAM4OeUVoB95tBrxd/VDCrdIvypVKldHsU3VkEbvPAl1jq68WVk+DXM
+FZqTUoafDK+irOvL7Z5j2gA3FDzRUQs0L+jCvRTl4omFSjSQwoBCoVXxNEAg9jgy
+lNWUHx+JHDB8dk+gEmDai20ggBWeAeThUU9dVZvwjv4E7zMRMx1skCRdWcyALJQf
+fjc9q6gnB9X9nPxXdWb/lYKcivJBmBRHLeirnUFL2S2IYRc2H0ZbX1d+WzDJV37+
+DKYy9ehltyHFiaXmZThJ2Kg/mAD55U3NCWNBXmQ0CvzhUh6QIQiOJNQHmK0qxgnc
+POJeE4X55dv1nAGD/0fGeHTcuShzUoipCKAd1CZdXK2Ge3gZRH2WUvlQGd5JARd4
+3zbd2wXZX0h0e1/BWQVeXx/Cg6u31B5lll7B3rWeoZHvfV9DSC7e3IEOhgzG5cyA
+h+wrtlCszjiMreHSSYCQh9tlyK+ACOJUFtZFGdseBsMxRgXWtHr+ypW2iJI4KsEU
+/MNXr1Bqg7FGxIw0Oyc2zyzjgD9aq4CKEy64MYB1ZYf41Rbc2Z+pMx1MW9orsPp7
+qSp6SmpTk0RTHpH0O2wNC9F26wIDAQABo4HjMIHgMB0GA1UdDgQWBBRzsbjWipVr
+EuB0fMVXVZiUW6x4XjCBowYDVR0jBIGbMIGYgBRzsbjWipVrEuB0fMVXVZiUW6x4
+XqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgMAk5BMRAwDgYDVQQHDAdCSVNI
+S0VLMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEWEm1lQG15
+aG9zdC5teWRvbWFpboIUb1C400ZucjRZvAAz3XyuEusnRgYwDAYDVR0TBAUwAwEB
+/zALBgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBABqhFuSPgqplHQtFnWwQ
+TKfrElQJ07gF0eaBBijQVSm2MswB2xnWF/S2NRjIpw7k5ZlmZsAbCVcGMwqJOkfJ
+yX3Z7gK+yNrZehzNSOCkv+H79ExsS9/HETSqZxMevIIH7O0t/pACv20f85unBzhc
+x+980RzufuHK17sG3Z+z+d6i9XDhaZvV/gm6bWTXft1ufRzI5R48xWVAfJd1X9Ln
+bZmqF9Ye1GHxka1Xna9nOCgAuYYoGxq2VkUSIjlRCMaLCHlsWEn0JbRnQXPfBts6
+/yQBywcEekKRutCugn5bn625kAJHWGxcb0xIXj+Rqnp2++p33lbE4J09zfIkh5hV
+RvCSzaE0Z3Kly9237CV+DyAqzrBJq5HHN/AT6+xFd2yGPMPKH8hKbf3jIprexNEp
+oG1XC/dsPFkPLUyeD++kVjzsLiDmYAn2x3Dco6cWD7FfEljb1pHkAp5CctU9TjZH
+21xcAsPbfS0vrDmj8zG7eTU+BtleL4AfxEVsMBzrUB6jSdUMpJ/hRtni4RxOHLmU
+0DqtHIqrDrC5Gb2KunNUIYqPp+80LSD1/Edo5Vr+k5AiFYCzZFXSab+6e4hEsLEV
+nQNMmcPVWATQ2najGfNftmhwQx9hU4gJaCw/rfhEmwIif5BxgG5VPUzy97T+GmOZ
+InB0RDylv3Lq3Hs8mBF4nRt7
 -----END CERTIFICATE-----
 </ca>
 #key sample-keys/client.key
 <key>
 -----BEGIN PRIVATE KEY-----
-MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDsZY/pEsIaW+ZW
-KgipgjotRHijADuwn+cnEECT7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLw
-SNr8FY3Exm0LmfErgwAK0yojC+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwd
-VyBxF4/3KJ4+B87s1Q5CTx50R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rR
-WNNE/loEAf8Gepf3/eNXSOHw30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhY
-HJMiC3X6qNbgtS8tudT+uU+G4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83
-DG9b/WHxAgMBAAECggEBAIOdaCpUD02trOh8LqZxowJhBOl7z7/ex0uweMPk67LT
-i5AdVHwOlzwZJ8oSIknoOBEMRBWcLQEojt1JMuL2/R95emzjIKshHHzqZKNulFvB
-TIUpdnwChTKtH0mqUkLlPU3Ienty4IpNlpmfUKimfbkWHERdBJBHbtDsTABhdo3X
-9pCF/yRKqJS2Fy/Mkl3gv1y/NB1OL4Jhl7vQbf+kmgfQN2qdOVe2BOKQ8NlPUDmE
-/1XNIDaE3s6uvUaoFfwowzsCCwN2/8QrRMMKkjvV+lEVtNmQdYxj5Xj5IwS0vkK0
-6icsngW87cpZxxc1zsRWcSTloy5ohub4FgKhlolmigECgYEA+cBlxzLvaMzMlBQY
-kCac9KQMvVL+DIFHlZA5i5L/9pRVp4JJwj3GUoehFJoFhsxnKr8HZyLwBKlCmUVm
-VxnshRWiAU18emUmeAtSGawlAS3QXhikVZDdd/L20YusLT+DXV81wlKR97/r9+17
-klQOLkSdPm9wcMDOWMNHX8bUg8kCgYEA8k+hQv6+TR/+Beao2IIctFtw/EauaJiJ
-wW5ql1cpCLPMAOQUvjs0Km3zqctfBF8mUjdkcyJ4uhL9FZtfywY22EtRIXOJ/8VR
-we65mVo6RLR8YVM54sihanuFOnlyF9LIBWB+9pUfh1/Y7DSebh7W73uxhAxQhi3Y
-QwfIQIFd8OkCgYBalH4VXhLYhpaYCiXSej6ot6rrK2N6c5Tb2MAWMA1nh+r84tMP
-gMoh+pDgYPAqMI4mQbxUmqZEeoLuBe6VHpDav7rPECRaW781AJ4ZM4cEQ3Jz/inz
-4qOAMn10CF081/Ez9ykPPlU0bsYNWHNd4eB2xWnmUBKOwk7UgJatVPaUiQKBgQCI
-f18CVGpzG9CHFnaK8FCnMNOm6VIaTcNcGY0mD81nv5Dt943P054BQMsAHTY7SjZW
-HioRyZtkhonXAB2oSqnekh7zzxgv4sG5k3ct8evdBCcE1FNJc2eqikZ0uDETRoOy
-s7cRxNNr+QxDkyikM+80HOPU1PMPgwfOSrX90GJQ8QKBgEBKohGMV/sNa4t14Iau
-qO8aagoqh/68K9GFXljsl3/iCSa964HIEREtW09Qz1w3dotEgp2w8bsDa+OwWrLy
-0SY7T5jRViM3cDWRlUBLrGGiL0FiwsfqiRiji60y19erJgrgyGVIb1kIgIBRkgFM
-2MMweASzTmZcri4PA/5C0HYb
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDdrrIKQObP4cGi
+odKDLDGY4huyhUBnAPqrv8+dFNHGt2ODql+cFKDSTQQ6SpLmkkukhkAmQr2Dt/xJ
+t1bSyudwhRaPizvaR56LakrI5qjermstUiIMnc9nu30eZgVTi3yurdGmUl89nmso
+GFfZoUItwLBN2krwKaoCNIYCqq9nCQbtRSGOjPh1Vsfq6E+IjhyLW2gtsWal5MY2
+4nCN/u8Q8FL4U5a/flFw8j+uWIc40aNr9jhRmxbOZzWObXZjTWubfXfaVW8gsWZP
+mi2kczpSIYY886ZaZ+V9EPU2ViF+AyK9mOkYtD+ztQ3t1e9Ulm+dRmxvDrpLGvfM
+1OUkutKlAgMBAAECggEANwi9ron6QzWaqtNdva7lCT1o/uLR4EB/+s99rVOT2K+C
+hxdu8QK2Aj+YgxgsbA15tfiWSGldPywX9/0KEv7IgkioFy7Lxx7sn1PeCQ4qck3+
+0ZuIVHWBHhGPuFI/lEQWyg7g81eTyWpg0+1nMeI02cLyggFlhUXyrOV5N4REU2GW
+C0KBQFyVQJPrFszomK8qsHOu/gaGC1vOwgIID3cQ3iLKXkoHNmHO4hgbeSy+SfDP
+Q5C0xxKQa2RUz0nLbByuGtLYOsJmbjUMWjFXyjmwBsPCcvRmFRdnxFvlnzwGEH4M
+ZKsw+49p1iJFyuCv7KJ/ILLJmoEuryjrSmdj3esIqQKBgQDwC24VBQLNmlug8rkG
+YWaRePsWRJylDlWIeHnfmGe27p7ytxOvGe6hnPu6nfg8nXHtruZCIhGya6qbuVmL
+vGrg94ia4MSpDVUgGiElXXQ/Pl7O9/lnSlIlxcBAgd8uggxIAzCeYI6c3r7AQcmY
+jARMwYNCxJjz5nLctMe2MCs4LwKBgQDsatDXb3xr6jmflCUZa8Kx8SOgBWEZTEGz
+KEoCQWnF2fHUCy4Bwm8Imnws3iX0198TyxkVD2rP8oGwFj2SAVtI2L8Y/g5A05TA
+knfmVECvGp/MN266ZdCA8G/MKbk727TxyJs+4AseAi5p6cBULqZHsJaZE74qlcEl
+5gFQu35ZawKBgBBgRz9J2zoZmLyvMm48ANpVzZNkVOdxxeYMigv2AsVZHCDk2oPs
+mfoOkqHVmxTPjPExKGZEmr54V+hNyc0dqpD0ci5WvTPnQ/JvtektqfuSjrdB9ZLV
+YCtRhV8hPQ+YMaxMA2oankAXdh35nv44NybhYMoSTXj+NMHX13QXbytjAoGAdVKw
+3yixWzB6dinjm1Dx5rJfVos024QPWqRUzfe+UPROYUdHBpKB3YgktXNs7KuwRbdV
+dDEZdabIGyV+WpWXwnflpbZ2Rk95k3NcUw5ep0cUJBkiNxhNt58aK/xMs1rd2dsO
+x84RVkwI0oCw9FXOKOeGZOL6TVHR70fMQU86bY8CgYEAqg/1AD9lXzbR57zaR/br
+AIn0WWU2mnU7Dc4uhmQd9+JExqrplKKHrUp8eQEOW8nij6MbPYlpgkMdatvDOJqP
+WrYtwZsKXGhnalvbS3ye20HqpjYpBR7co3Q9KMaaDNoQe9HtjbT80GXpQEbJN2Iu
+ADo3hPoX0yENIbKFccMuptM=
 -----END PRIVATE KEY-----
 </key>
 #cert sample-keys/client.crt
@@ -96,104 +97,104 @@ Certificate:
     Data:
         Version: 3 (0x2)
         Serial Number: 2 (0x2)
-    Signature Algorithm: sha256WithRSAEncryption
+        Signature Algorithm: sha256WithRSAEncryption
         Issuer: C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST/emailAddress=me@...430...
         Validity
-            Not Before: Oct 22 21:59:53 2014 GMT
-            Not After : Oct 19 21:59:53 2024 GMT
+            Not Before: Nov  7 12:23:39 2023 GMT
+            Not After : Nov  4 12:23:39 2033 GMT
         Subject: C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Client/emailAddress=me@...430...
         Subject Public Key Info:
             Public Key Algorithm: rsaEncryption
                 Public-Key: (2048 bit)
                 Modulus:
-                    00:ec:65:8f:e9:12:c2:1a:5b:e6:56:2a:08:a9:82:
-                    3a:2d:44:78:a3:00:3b:b0:9f:e7:27:10:40:93:ef:
-                    f1:cc:3e:a0:aa:04:a2:80:1b:13:a9:e6:fe:81:d6:
-                    70:90:a8:d8:d4:de:30:d8:35:00:d2:be:62:f0:48:
-                    da:fc:15:8d:c4:c6:6d:0b:99:f1:2b:83:00:0a:d3:
-                    2a:23:0b:e5:cd:f9:35:df:43:61:15:72:ad:95:98:
-                    f6:73:21:41:5e:a0:dd:47:27:a0:d5:9a:d4:41:a8:
-                    1c:1d:57:20:71:17:8f:f7:28:9e:3e:07:ce:ec:d5:
-                    0e:42:4f:1e:74:47:8e:47:9d:d2:14:28:27:2c:14:
-                    10:f5:d1:96:b5:93:74:84:ef:f9:04:de:8d:4a:6f:
-                    df:77:ab:ea:d1:58:d3:44:fe:5a:04:01:ff:06:7a:
-                    97:f7:fd:e3:57:48:e1:f0:df:40:13:9f:66:23:5a:
-                    e3:55:54:3d:54:39:ee:00:f9:12:f1:d2:df:74:2e:
-                    ba:d7:f0:8d:c6:dd:18:58:1c:93:22:0b:75:fa:a8:
-                    d6:e0:b5:2f:2d:b9:d4:fe:b9:4f:86:e2:75:48:16:
-                    60:fb:3f:c9:b4:30:42:29:fb:3b:b3:2b:b9:59:81:
-                    6a:46:f3:45:83:bf:fd:d5:1a:ff:37:0c:6f:5b:fd:
-                    61:f1
+                    00:dd:ae:b2:0a:40:e6:cf:e1:c1:a2:a1:d2:83:2c:
+                    31:98:e2:1b:b2:85:40:67:00:fa:ab:bf:cf:9d:14:
+                    d1:c6:b7:63:83:aa:5f:9c:14:a0:d2:4d:04:3a:4a:
+                    92:e6:92:4b:a4:86:40:26:42:bd:83:b7:fc:49:b7:
+                    56:d2:ca:e7:70:85:16:8f:8b:3b:da:47:9e:8b:6a:
+                    4a:c8:e6:a8:de:ae:6b:2d:52:22:0c:9d:cf:67:bb:
+                    7d:1e:66:05:53:8b:7c:ae:ad:d1:a6:52:5f:3d:9e:
+                    6b:28:18:57:d9:a1:42:2d:c0:b0:4d:da:4a:f0:29:
+                    aa:02:34:86:02:aa:af:67:09:06:ed:45:21:8e:8c:
+                    f8:75:56:c7:ea:e8:4f:88:8e:1c:8b:5b:68:2d:b1:
+                    66:a5:e4:c6:36:e2:70:8d:fe:ef:10:f0:52:f8:53:
+                    96:bf:7e:51:70:f2:3f:ae:58:87:38:d1:a3:6b:f6:
+                    38:51:9b:16:ce:67:35:8e:6d:76:63:4d:6b:9b:7d:
+                    77:da:55:6f:20:b1:66:4f:9a:2d:a4:73:3a:52:21:
+                    86:3c:f3:a6:5a:67:e5:7d:10:f5:36:56:21:7e:03:
+                    22:bd:98:e9:18:b4:3f:b3:b5:0d:ed:d5:ef:54:96:
+                    6f:9d:46:6c:6f:0e:ba:4b:1a:f7:cc:d4:e5:24:ba:
+                    d2:a5
                 Exponent: 65537 (0x10001)
         X509v3 extensions:
-            X509v3 Basic Constraints:
+            X509v3 Basic Constraints: 
                 CA:FALSE
-            X509v3 Subject Key Identifier:
-                D2:B4:36:0F:B1:FC:DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D
-            X509v3 Authority Key Identifier:
-                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
+            X509v3 Subject Key Identifier: 
+                59:33:B9:2E:63:D1:17:A8:9F:BD:D8:CE:94:21:C5:41:C7:31:62:5D
+            X509v3 Authority Key Identifier: 
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E
                 DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
-                serial:A1:4E:DE:FA:90:F2:AE:81
-
+                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
     Signature Algorithm: sha256WithRSAEncryption
-         7f:e0:fe:84:a7:ec:df:62:a5:cd:3c:c1:e6:42:b1:31:12:f0:
-         b9:da:a7:9e:3f:bd:96:52:b6:fc:55:74:64:3e:e4:ff:7e:aa:
-         f7:3e:06:18:5f:73:85:f8:c8:e0:67:1b:4d:97:ca:05:d0:37:
-         07:33:64:9b:e6:78:77:14:9a:55:bb:2a:ac:c3:7f:c9:15:08:
-         83:5c:c8:c2:61:d3:71:4c:05:0b:2b:cb:a3:87:6d:a0:32:ed:
-         b0:b3:27:97:4a:55:8d:01:2a:30:56:68:ab:f2:da:5c:10:73:
-         c9:aa:0a:9c:4b:4c:a0:5b:51:6e:0a:7e:6c:53:80:b0:00:e1:
-         1e:9a:4c:0a:37:9e:20:89:bc:c5:e5:79:58:b7:45:ff:d3:c4:
-         a1:fd:d9:78:3d:45:16:74:df:82:44:1d:1d:81:50:5a:b9:32:
-         4c:e2:4f:3f:0e:3a:65:5a:64:83:3b:29:31:c4:99:88:bc:c5:
-         84:39:f2:19:12:e1:66:d0:ea:fb:75:b1:d2:27:be:91:59:a3:
-         2b:09:d5:5c:bf:46:8e:d6:67:d6:0b:ec:da:ab:f0:80:19:87:
-         64:07:a9:77:b1:5e:0c:e2:c5:1d:6a:ac:5d:23:f3:30:75:36:
-         4e:ca:c3:4e:b0:4d:8c:2c:ce:52:61:63:de:d5:f5:ef:ef:0a:
-         6b:23:25:26:3c:3a:f2:c3:c2:16:19:3f:a9:32:ba:68:f9:c9:
-         12:3c:3e:c6:1f:ff:9b:4e:f4:90:b0:63:f5:d1:33:00:30:5a:
-         e8:24:fa:35:44:9b:6a:80:f3:a6:cc:7b:3c:73:5f:50:c4:30:
-         71:d8:74:90:27:0a:01:4e:a5:5e:b1:f8:da:c2:61:81:11:ae:
-         29:a3:8f:fa:7e:4c:4e:62:b1:00:de:92:e3:8f:6a:2e:da:d9:
-         38:5d:6b:7c:0d:e4:01:aa:c8:c6:6d:8b:cd:c0:c8:6e:e4:57:
-         21:8a:f6:46:30:d9:ad:51:a1:87:96:a6:53:c9:1e:c6:bb:c3:
-         eb:55:fe:8c:d6:5c:d5:c6:f3:ca:b0:60:d2:d4:2a:1f:88:94:
-         d3:4c:1a:da:0c:94:fe:c1:5d:0d:2a:db:99:29:5d:f6:dd:16:
-         c4:c8:4d:74:9e:80:d9:d0:aa:ed:7b:e3:30:e4:47:d8:f5:15:
-         c1:71:b8:c6:fd:ee:fc:9e:b2:5f:b5:b7:92:ed:ff:ca:37:f6:
-         c7:82:b4:54:13:9b:83:cd:87:8b:7e:64:f6:2e:54:3a:22:b1:
-         c5:c1:f4:a5:25:53:9a:4d:a8:0f:e7:35:4b:89:df:19:83:66:
-         64:d9:db:d1:61:2b:24:1b:1d:44:44:fb:49:30:87:b7:49:23:
-         08:02:8a:e0:25:f3:f4:43
+    Signature Value:
+        2a:9e:02:65:f4:3c:c0:37:88:f0:21:f9:fd:2e:7c:f4:8b:bb:
+        67:7d:f7:48:0c:98:f7:a1:46:4e:33:af:68:77:f4:53:03:09:
+        fd:4e:32:cb:0f:2c:f1:16:37:35:65:aa:68:79:16:a9:32:03:
+        d7:89:10:ef:ba:fd:e1:26:2c:60:7c:3b:42:60:68:47:cf:61:
+        88:00:77:e7:71:76:49:78:35:52:45:a4:31:7e:2b:e1:0a:c8:
+        ed:e1:a7:28:2f:23:a3:ce:ce:b5:99:6b:54:4d:df:d2:64:0a:
+        b7:c5:25:1e:d4:f7:a1:fd:4f:f3:12:d3:26:5f:3b:b2:93:93:
+        d1:8b:4b:4e:dc:d0:15:63:d1:77:36:75:34:76:37:59:ff:a0:
+        81:01:ec:b6:42:2f:bd:85:5d:d0:ef:ff:90:61:d6:91:b0:f5:
+        e6:94:66:7e:4c:20:06:c4:2e:0c:9b:9f:7f:89:f0:3e:8f:e5:
+        06:6c:81:75:a2:0b:c5:ac:44:f1:32:cc:57:90:a0:19:47:8c:
+        25:7a:d5:f1:61:1f:19:bf:4c:31:da:44:c1:30:91:e8:b5:cc:
+        e4:7e:20:55:0a:b9:dc:f3:5e:f5:7c:d1:0b:ee:71:c6:d6:38:
+        7e:85:7b:6c:cb:10:85:1e:6a:50:ab:c3:ae:f9:ff:96:4f:a3:
+        76:d6:fd:c0:f9:c7:9a:60:a8:8c:e5:9a:c5:a9:7b:63:11:ef:
+        7b:b9:9b:1f:63:51:a8:6d:2b:d6:f7:ef:51:bd:a8:32:9e:92:
+        aa:24:01:c9:e3:6a:c8:94:2e:d2:66:b2:c7:17:e5:06:53:9a:
+        bd:8a:19:8f:3a:51:7a:25:11:e5:e8:59:f7:1b:df:95:98:35:
+        c1:a6:74:15:6b:b1:2c:97:9b:fe:76:7e:56:20:4d:ee:07:8a:
+        b9:8b:bc:92:a9:19:81:28:91:4e:d2:9f:51:99:72:c0:12:76:
+        5b:c8:74:68:b5:9d:43:53:c1:af:39:b9:28:82:a0:0e:bb:ef:
+        21:d8:71:dd:02:af:dc:df:48:7b:39:21:7d:83:76:ea:e2:c7:
+        16:bb:d2:1a:1d:22:f6:4b:47:15:56:41:06:4d:39:1c:96:3f:
+        25:2d:83:8f:a4:a2:86:fa:0e:e9:45:9c:bf:26:40:e6:3e:9e:
+        d5:00:9f:ce:76:6f:df:cb:b2:85:b8:83:f2:ed:8b:b6:5a:68:
+        b5:c7:1b:ab:19:75:60:f3:5b:e7:5c:70:27:d9:1c:d8:24:f0:
+        2a:aa:2a:a6:98:77:d6:36:d9:02:35:a8:d3:2c:19:88:b8:0b:
+        d3:76:58:72:54:99:94:9a:ee:38:9b:8d:8e:10:48:cd:28:50:
+        31:b2:4b:d3:69:7b:91:b4
 -----BEGIN CERTIFICATE-----
-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
+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
-DQEBAQUAA4IBDwAwggEKAoIBAQDsZY/pEsIaW+ZWKgipgjotRHijADuwn+cnEECT
-7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLwSNr8FY3Exm0LmfErgwAK0yoj
-C+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwdVyBxF4/3KJ4+B87s1Q5CTx50
-R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rRWNNE/loEAf8Gepf3/eNXSOHw
-30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhYHJMiC3X6qNbgtS8tudT+uU+G
-4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83DG9b/WHxAgMBAAGjgcgwgcUw
-CQYDVR0TBAIwADAdBgNVHQ4EFgQU0rQ2D7H83aXqKvfHI4n64/p6RB0wgZgGA1Ud
-IwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJBgNVBAYTAktH
-MQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMMT3BlblZQ
-Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CCQChTt76
-kPKugTANBgkqhkiG9w0BAQsFAAOCAgEAf+D+hKfs32KlzTzB5kKxMRLwudqnnj+9
-llK2/FV0ZD7k/36q9z4GGF9zhfjI4GcbTZfKBdA3BzNkm+Z4dxSaVbsqrMN/yRUI
-g1zIwmHTcUwFCyvLo4dtoDLtsLMnl0pVjQEqMFZoq/LaXBBzyaoKnEtMoFtRbgp+
-bFOAsADhHppMCjeeIIm8xeV5WLdF/9PEof3ZeD1FFnTfgkQdHYFQWrkyTOJPPw46
-ZVpkgzspMcSZiLzFhDnyGRLhZtDq+3Wx0ie+kVmjKwnVXL9GjtZn1gvs2qvwgBmH
-ZAepd7FeDOLFHWqsXSPzMHU2TsrDTrBNjCzOUmFj3tX17+8KayMlJjw68sPCFhk/
-qTK6aPnJEjw+xh//m070kLBj9dEzADBa6CT6NUSbaoDzpsx7PHNfUMQwcdh0kCcK
-AU6lXrH42sJhgRGuKaOP+n5MTmKxAN6S449qLtrZOF1rfA3kAarIxm2LzcDIbuRX
-IYr2RjDZrVGhh5amU8kexrvD61X+jNZc1cbzyrBg0tQqH4iU00wa2gyU/sFdDSrb
-mSld9t0WxMhNdJ6A2dCq7XvjMORH2PUVwXG4xv3u/J6yX7W3ku3/yjf2x4K0VBOb
-g82Hi35k9i5UOiKxxcH0pSVTmk2oD+c1S4nfGYNmZNnb0WErJBsdRET7STCHt0kj
-CAKK4CXz9EM=
+DQEBAQUAA4IBDwAwggEKAoIBAQDdrrIKQObP4cGiodKDLDGY4huyhUBnAPqrv8+d
+FNHGt2ODql+cFKDSTQQ6SpLmkkukhkAmQr2Dt/xJt1bSyudwhRaPizvaR56LakrI
+5qjermstUiIMnc9nu30eZgVTi3yurdGmUl89nmsoGFfZoUItwLBN2krwKaoCNIYC
+qq9nCQbtRSGOjPh1Vsfq6E+IjhyLW2gtsWal5MY24nCN/u8Q8FL4U5a/flFw8j+u
+WIc40aNr9jhRmxbOZzWObXZjTWubfXfaVW8gsWZPmi2kczpSIYY886ZaZ+V9EPU2
+ViF+AyK9mOkYtD+ztQ3t1e9Ulm+dRmxvDrpLGvfM1OUkutKlAgMBAAGjgdMwgdAw
+CQYDVR0TBAIwADAdBgNVHQ4EFgQUWTO5LmPRF6ifvdjOlCHFQccxYl0wgaMGA1Ud
+IwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYTAktH
+MQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3BlblZQ
+Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9QuNNG
+bnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQAqngJl9DzAN4jwIfn9
+Lnz0i7tnffdIDJj3oUZOM69od/RTAwn9TjLLDyzxFjc1ZapoeRapMgPXiRDvuv3h
+JixgfDtCYGhHz2GIAHfncXZJeDVSRaQxfivhCsjt4acoLyOjzs61mWtUTd/SZAq3
+xSUe1Peh/U/zEtMmXzuyk5PRi0tO3NAVY9F3NnU0djdZ/6CBAey2Qi+9hV3Q7/+Q
+YdaRsPXmlGZ+TCAGxC4Mm59/ifA+j+UGbIF1ogvFrETxMsxXkKAZR4wletXxYR8Z
+v0wx2kTBMJHotczkfiBVCrnc8171fNEL7nHG1jh+hXtsyxCFHmpQq8Ou+f+WT6N2
+1v3A+ceaYKiM5ZrFqXtjEe97uZsfY1GobSvW9+9RvagynpKqJAHJ42rIlC7SZrLH
+F+UGU5q9ihmPOlF6JRHl6Fn3G9+VmDXBpnQVa7Esl5v+dn5WIE3uB4q5i7ySqRmB
+KJFO0p9RmXLAEnZbyHRotZ1DU8GvObkogqAOu+8h2HHdAq/c30h7OSF9g3bq4scW
+u9IaHSL2S0cVVkEGTTkclj8lLYOPpKKG+g7pRZy/JkDmPp7VAJ/Odm/fy7KFuIPy
+7Yu2Wmi1xxurGXVg81vnXHAn2RzYJPAqqiqmmHfWNtkCNajTLBmIuAvTdlhyVJmU
+mu44m42OEEjNKFAxskvTaXuRtA==
 -----END CERTIFICATE-----
 </cert>
 #tls-auth sample-keys/ta.key 1
@@ -203,22 +204,22 @@ key-direction 1
 # 2048 bit OpenVPN static key
 #
 -----BEGIN OpenVPN Static key V1-----
-a863b1cbdb911ff4ef3360ce135157e7
-241a465f5045f51cf9a92ebc24da34fd
-5fc48456778c977e374d55a8a7298aef
-40d0ab0c60b5e09838510526b73473a0
-8da46a8c352572dd86d4a871700a915b
-6aaa58a9dac560db2dfdd7ef15a202e1
-fca6913d7ee79c678c5798fbf7bd920c
-caa7a64720908da7254598b052d07f55
-5e31dc5721932cffbdd8965d04107415
-46c86823da18b66aab347e4522cc05ff
-634968889209c96b1024909cd4ce574c
-f829aa9c17d5df4a66043182ee23635d
-8cabf5a7ba02345ad94a3aa25a63d55c
-e13f4ad235a0825e3fe17f9419baff1c
-e73ad1dd652f1e48c7102fe8ee181e54
-10a160ae255f63fd01db1f29e6efcb8e
+21d94830510107f8753d3b6f3145e01d
+ed37075115afcb0538ecdd8503ee9663
+7218c9ed38d908d594231d7d143c73da
+5055310f89d336da99c8b3dcb18909c7
+9dd44f540670ebc0f120beb7211e9683
+9cb542572c48bfa7ffaa9a22cb8304b7
+869b92f4442918e598745bb78ac8877f
+02b00a7cdef3f2446c130d39a7c45126
+9ef399fd6029cdfc80a7c604041312ab
+0a969bc906bdee6e6d707afdcbe8c7fb
+97beb66049c3d328340775025433ceba
+1e38008a826cf92443d903106199373b
+dadd9c2c735cf481e580db4e81b99f12
+e3f46b6159c687cd1b9e689f7712573c
+0f02735a45573dfb5cd55cf464942389
+2c7e91f439bdd7337a8ceebd302cfbfa
 -----END OpenVPN Static key V1-----
 </tls-auth>
 cipher AES-256-GCM
diff --git a/sample/sample-keys/ca.crt b/sample/sample-keys/ca.crt
index a11bafa7..a088711b 100644
--- a/sample/sample-keys/ca.crt
+++ b/sample/sample-keys/ca.crt
@@ -1,35 +1,36 @@
 -----BEGIN CERTIFICATE-----
-MIIGKDCCBBCgAwIBAgIJAKFO3vqQ8q6BMA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV
-BAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UEChMM
-T3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4w
-HhcNMTQxMDIyMjE1OTUyWhcNMjQxMDE5MjE1OTUyWjBmMQswCQYDVQQGEwJLRzEL
-MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMIICIjANBgkq
-hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsJVPCqt3vtoDW2U0DII1QIh2Qs0dqh88
-8nivxAIm2LTq93e9fJhsq3P/UVYAYSeCIrekXypR0EQgSgcNTvGBMe20BoHO5yvb
-GjKPmjfLj6XRotCOGy8EDl/hLgRY9efiA8wsVfuvF2q/FblyJQPR/gPiDtTmUiqF
-qXa7AJmMrqFsnWppOuGd7Qc6aTsae4TF1e/gUTCTraa7NeHowDaKhdyFmEEnCYR5
-CeUsx2JlFWAH8PCrxBpHYbmGyvS0kH3+rQkaSM/Pzc2bS4ayHaOYRK5XsGq8XiNG
-KTTLnSaCdPeHsI+3xMHmEh+u5Og2DFGgvyD22gde6W2ezvEKCUDrzR7bsnYqqyUy
-n7LxnkPXGyvR52T06G8KzLKQRmDlPIXhzKMO07qkHmIonXTdF7YI1azwHpAtN4dS
-rUe1bvjiTSoEsQPfOAyvD0RMK/CBfgEZUzAB50e/IlbZ84c0DJfUMOm4xCyft1HF
-YpYeyCf5dxoIjweCPOoP426+aTXM7kqq0ieIr6YxnKV6OGGLKEY+VNZh1DS7enqV
-HP5i8eimyuUYPoQhbK9xtDGMgghnc6Hn8BldPMcvz98HdTEH4rBfA3yNuCxLSNow
-4jJuLjNXh2QeiUtWtkXja7ec+P7VqKTduJoRaX7cs+8E3ImigiRnvmK+npk7Nt1y
-YE9hBRhSoLsCAwEAAaOB2DCB1TAdBgNVHQ4EFgQUK0DlyX319JY46S/jL9lAZMmO
-BZswgZgGA1UdIwSBkDCBjYAUK0DlyX319JY46S/jL9lAZMmOBZuhaqRoMGYxCzAJ
-BgNVBAYTAktHMQswCQYDVQQIEwJOQTEQMA4GA1UEBxMHQklTSEtFSzEVMBMGA1UE
-ChMMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h
-aW6CCQChTt76kPKugTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG
-9w0BAQsFAAOCAgEABc77f4C4P8fIS+V8qCJmVNSDU44UZBc+D+J6ZTgW8JeOHUIj
-Bh++XDg3gwat7pIWQ8AU5R7h+fpBI9n3dadyIsMHGwSogHY9Gw7di2RVtSFajEth
-rvrq0JbzpwoYedMh84sJ2qI/DGKW9/Is9+O52fR+3z3dY3gNRDPQ5675BQ5CQW9I
-AJgLOqzD8Q0qrXYi7HaEqzNx6p7RDTuhFgvTd+vS5d5+28Z5fm2umnq+GKHF8W5P
-ylp2Js119FTVO7brusAMKPe5emc7tC2ov8OFFemQvfHR41PLryap2VD81IOgmt/J
-kX/j/y5KGux5HZ3lxXqdJbKcAq4NKYQT0mCkRD4l6szaCEJ+k0SiM9DdTcBDefhR
-9q+pCOyMh7d8QjQ1075mF7T+PGkZQUW1DUjEfrZhICnKgq+iEoUmM0Ee5WtRqcnu
-5BTGQ2mSfc6rV+Vr+eYXqcg7Nxb3vFXYSTod1UhefonVqwdmyJ2sC79zp36Tbo2+
-65NW2WJK7KzPUyOJU0U9bcu0utvDOvGWmG+aHbymJgcoFzvZmlXqMXn97pSFn4jV
-y3SLRgJXOw1QLXL2Y5abcuoBVr4gCOxxk2vBeVxOMRXNqSWZOFIF1bu/PxuDA+Sa
-hEi44aHbPXt9opdssz/hdGfd8Wo7vEJrbg7c6zR6C/Akav1Rzy9oohIdgOw=
+MIIGPjCCBCagAwIBAgIUb1C400ZucjRZvAAz3XyuEusnRgYwDQYJKoZIhvcNAQEL
+BQAwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgMAk5BMRAwDgYDVQQHDAdCSVNIS0VL
+MRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEWEm1lQG15aG9z
+dC5teWRvbWFpbjAeFw0yMzExMDcxMjIzMzlaFw0zMzExMDQxMjIzMzlaMGYxCzAJ
+BgNVBAYTAktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UE
+CgwMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21h
+aW4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCI+p/ZLGUHCANTTFaK
+nw+J3wi+ef2EKJ5WHt5PWMuBeaDpeU4Ghuaow8HlRPjG9lDRHtn+WQgZz9nUejYH
++wtmN2BHwJAM4OeUVoB95tBrxd/VDCrdIvypVKldHsU3VkEbvPAl1jq68WVk+DXM
+FZqTUoafDK+irOvL7Z5j2gA3FDzRUQs0L+jCvRTl4omFSjSQwoBCoVXxNEAg9jgy
+lNWUHx+JHDB8dk+gEmDai20ggBWeAeThUU9dVZvwjv4E7zMRMx1skCRdWcyALJQf
+fjc9q6gnB9X9nPxXdWb/lYKcivJBmBRHLeirnUFL2S2IYRc2H0ZbX1d+WzDJV37+
+DKYy9ehltyHFiaXmZThJ2Kg/mAD55U3NCWNBXmQ0CvzhUh6QIQiOJNQHmK0qxgnc
+POJeE4X55dv1nAGD/0fGeHTcuShzUoipCKAd1CZdXK2Ge3gZRH2WUvlQGd5JARd4
+3zbd2wXZX0h0e1/BWQVeXx/Cg6u31B5lll7B3rWeoZHvfV9DSC7e3IEOhgzG5cyA
+h+wrtlCszjiMreHSSYCQh9tlyK+ACOJUFtZFGdseBsMxRgXWtHr+ypW2iJI4KsEU
+/MNXr1Bqg7FGxIw0Oyc2zyzjgD9aq4CKEy64MYB1ZYf41Rbc2Z+pMx1MW9orsPp7
+qSp6SmpTk0RTHpH0O2wNC9F26wIDAQABo4HjMIHgMB0GA1UdDgQWBBRzsbjWipVr
+EuB0fMVXVZiUW6x4XjCBowYDVR0jBIGbMIGYgBRzsbjWipVrEuB0fMVXVZiUW6x4
+XqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgMAk5BMRAwDgYDVQQHDAdCSVNI
+S0VLMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEWEm1lQG15
+aG9zdC5teWRvbWFpboIUb1C400ZucjRZvAAz3XyuEusnRgYwDAYDVR0TBAUwAwEB
+/zALBgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBABqhFuSPgqplHQtFnWwQ
+TKfrElQJ07gF0eaBBijQVSm2MswB2xnWF/S2NRjIpw7k5ZlmZsAbCVcGMwqJOkfJ
+yX3Z7gK+yNrZehzNSOCkv+H79ExsS9/HETSqZxMevIIH7O0t/pACv20f85unBzhc
+x+980RzufuHK17sG3Z+z+d6i9XDhaZvV/gm6bWTXft1ufRzI5R48xWVAfJd1X9Ln
+bZmqF9Ye1GHxka1Xna9nOCgAuYYoGxq2VkUSIjlRCMaLCHlsWEn0JbRnQXPfBts6
+/yQBywcEekKRutCugn5bn625kAJHWGxcb0xIXj+Rqnp2++p33lbE4J09zfIkh5hV
+RvCSzaE0Z3Kly9237CV+DyAqzrBJq5HHN/AT6+xFd2yGPMPKH8hKbf3jIprexNEp
+oG1XC/dsPFkPLUyeD++kVjzsLiDmYAn2x3Dco6cWD7FfEljb1pHkAp5CctU9TjZH
+21xcAsPbfS0vrDmj8zG7eTU+BtleL4AfxEVsMBzrUB6jSdUMpJ/hRtni4RxOHLmU
+0DqtHIqrDrC5Gb2KunNUIYqPp+80LSD1/Edo5Vr+k5AiFYCzZFXSab+6e4hEsLEV
+nQNMmcPVWATQ2najGfNftmhwQx9hU4gJaCw/rfhEmwIif5BxgG5VPUzy97T+GmOZ
+InB0RDylv3Lq3Hs8mBF4nRt7
 -----END CERTIFICATE-----
diff --git a/sample/sample-keys/ca.key b/sample/sample-keys/ca.key
index 8b11bc22..e9238844 100644
--- a/sample/sample-keys/ca.key
+++ b/sample/sample-keys/ca.key
@@ -1,52 +1,52 @@
 -----BEGIN PRIVATE KEY-----
-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
-B1RaqQXwzqrCH0F/vw3lRceYhcQvzcQ=
+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
+C2j6oHefg+K1iyTA4LCTAkHWax2ggg==
 -----END PRIVATE KEY-----
diff --git a/sample/sample-keys/client-ec.crt b/sample/sample-keys/client-ec.crt
index 759dabae..5fc27c6d 100644
--- a/sample/sample-keys/client-ec.crt
+++ b/sample/sample-keys/client-ec.crt
@@ -1,85 +1,86 @@
 Certificate:
     Data:
         Version: 3 (0x2)
-        Serial Number: 4 (0x4)
-    Signature Algorithm: sha256WithRSAEncryption
+        Serial Number: 7 (0x7)
+        Signature Algorithm: sha256WithRSAEncryption
         Issuer: C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST/emailAddress=me@...430...
         Validity
-            Not Before: Oct 22 21:59:53 2014 GMT
-            Not After : Oct 19 21:59:53 2024 GMT
+            Not Before: Nov  7 12:23:40 2023 GMT
+            Not After : Nov  4 12:23:40 2033 GMT
         Subject: C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Client-EC/emailAddress=me@...430...
         Subject Public Key Info:
             Public Key Algorithm: id-ecPublicKey
                 Public-Key: (256 bit)
                 pub:
-                    04:3b:ce:62:5d:6f:87:82:75:24:c2:58:f5:0e:88:
-                    4d:57:0d:06:b2:71:88:87:58:19:bb:de:5f:7f:52:
-                    62:51:a2:48:91:83:48:91:90:3e:87:02:0f:15:51:
-                    f9:68:97:12:0a:fd:d2:3c:87:83:4b:65:54:00:44:
-                    8d:28:76:49:05
+                    04:25:bd:3e:da:c5:cd:35:c0:44:d5:82:11:77:7a:
+                    24:12:1e:40:53:7a:ff:0d:0c:67:05:94:ce:5d:44:
+                    26:51:9b:0c:57:b1:38:30:9d:bd:13:03:59:12:0e:
+                    c8:35:5c:ca:b6:d1:81:41:9d:ac:9f:ec:2b:58:07:
+                    29:6d:d3:5f:5c
                 ASN1 OID: secp256k1
         X509v3 extensions:
-            X509v3 Basic Constraints:
+            X509v3 Basic Constraints: 
                 CA:FALSE
-            X509v3 Subject Key Identifier:
-                64:F6:49:88:E7:74:C1:AB:A5:FA:4F:2B:71:3C:25:13:3D:C8:94:C5
-            X509v3 Authority Key Identifier:
-                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
+            X509v3 Subject Key Identifier: 
+                D4:76:DB:EC:D0:11:63:0E:FE:BA:4E:10:76:22:07:D7:99:02:DE:F6
+            X509v3 Authority Key Identifier: 
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E
                 DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
-                serial:A1:4E:DE:FA:90:F2:AE:81
-
+                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
     Signature Algorithm: sha256WithRSAEncryption
-         32:3d:f0:08:67:dd:03:73:76:cc:76:52:0a:f6:97:d1:c6:fa:
-         5f:d3:e6:28:c9:75:a7:08:a8:34:49:69:cf:eb:ab:da:86:b3:
-         2e:65:17:ee:7e:b6:b5:6b:15:0b:dc:11:3a:b9:5a:b3:80:b8:
-         bb:f4:6c:cf:88:3a:10:83:7e:10:a0:82:87:6e:06:ec:78:62:
-         d4:d1:44:27:dd:2c:19:d8:1a:a1:ae:f4:a0:00:7f:53:5a:40:
-         8a:c2:83:77:4b:26:7d:53:b0:d3:0f:2f:7c:28:70:ef:74:58:
-         5b:de:81:94:4c:63:19:f0:79:cb:6c:b2:ec:32:1b:4b:e4:62:
-         22:4f:ad:ac:4a:6f:a9:6e:c4:2a:8d:8a:88:19:09:fd:88:93:
-         3c:27:4d:91:95:ff:57:84:13:fd:4a:68:db:20:df:10:e6:81:
-         1d:fd:e7:1d:35:fb:19:02:dd:b5:5f:a0:c1:07:ec:74:b4:ef:
-         8b:f9:33:9a:f2:a6:3b:6e:b6:4a:52:ab:5d:99:76:64:62:c4:
-         d5:3a:c6:81:8d:eb:c8:4b:02:af:e1:ca:60:e9:8d:c7:a9:2b:
-         ea:4f:56:31:d3:9a:11:c2:9c:83:5c:a2:8d:98:fe:cc:a5:ad:
-         1f:51:c4:6e:cf:ff:a0:51:64:c8:7f:7f:32:05:4c:8d:7f:bf:
-         b8:ed:e5:81:5f:81:bd:1d:9b:3f:8a:83:27:26:b4:69:84:8b:
-         e5:d9:ea:fd:08:a8:aa:e4:3a:dc:29:4d:80:6c:13:f7:45:ce:
-         92:f2:a9:f3:5f:90:83:d6:23:0f:50:e5:40:09:4c:6b:f2:73:
-         aa:d8:49:a7:a9:81:6e:bb:f2:e4:a5:7f:19:39:1d:65:f3:11:
-         97:b1:2b:7c:2f:36:77:7f:75:fd:88:44:90:7c:f2:33:8d:cd:
-         2c:f6:76:60:33:d3:f4:b3:8c:81:d7:85:89:cc:d7:d5:2c:94:
-         a9:31:3f:d3:63:a7:dc:82:3f:0a:d8:c5:71:97:69:3b:c1:69:
-         cb:f0:1b:be:15:c0:be:aa:fd:e8:13:2c:0c:3f:72:7b:7d:9c:
-         3b:7f:b8:82:36:4b:ad:4d:16:19:b9:1c:b3:2d:d7:5f:8b:f8:
-         14:ce:d4:13:e5:82:7a:1d:40:28:08:65:4a:19:d7:7a:35:09:
-         db:36:48:4b:96:44:bd:1f:12:b2:39:08:1e:5b:66:25:9b:e0:
-         16:d3:79:05:e3:f6:90:da:95:95:33:a1:53:a8:3c:a9:f0:b2:
-         f5:d0:aa:80:a0:96:ca:8c:45:62:c2:74:04:91:68:27:fb:e9:
-         97:be:3a:87:8a:85:28:2d:6e:a9:60:9b:63:ba:65:98:5e:bb:
-         02:ee:ac:ba:be:f6:42:26
+    Signature Value:
+        72:fd:18:d4:c2:0f:ba:6f:94:f2:f9:26:8b:93:fb:d5:99:df:
+        f7:aa:e6:27:f2:89:86:ff:6d:0a:24:ea:ae:d4:68:7b:08:38:
+        8a:7a:f9:a2:4d:e5:fe:2e:e1:bb:09:8c:2d:df:85:7b:01:dd:
+        58:4b:15:2a:db:49:10:ab:f1:78:49:fb:94:b3:31:e3:09:e0:
+        63:3c:d0:f2:34:18:de:37:0a:2d:d3:02:d5:ae:05:49:57:e7:
+        47:d0:70:3f:f1:35:28:82:79:00:b3:c8:45:00:86:77:d7:68:
+        63:d2:3d:8b:ef:a9:f8:99:97:fe:d0:0a:98:cb:7a:7b:73:28:
+        77:f4:bb:cf:1c:63:7e:64:60:87:f7:51:68:e9:7a:90:70:d8:
+        a0:e2:c6:88:70:62:2c:49:ac:ba:8c:2e:c5:d7:c9:42:8b:44:
+        cc:ae:f3:40:79:1c:99:09:2c:4c:24:89:55:41:ce:c6:52:a9:
+        a3:b7:4c:e6:75:63:4f:b6:70:84:1b:3e:56:f5:42:5f:b1:50:
+        46:eb:33:41:28:f8:30:f6:f9:f9:c0:5d:9b:a4:af:8e:03:c8:
+        3e:88:66:04:2e:5b:ec:50:36:a8:d1:9f:8e:e0:59:40:bb:f8:
+        ff:45:7d:40:2e:6d:f0:e8:84:5b:db:7e:0d:88:b3:a2:f6:34:
+        5b:b9:a1:1d:a0:fa:85:78:3b:9b:b3:0b:6c:f1:03:06:9c:f1:
+        e3:ba:64:a3:5c:d8:c8:d5:73:4a:3f:4d:83:aa:e8:c4:ce:dd:
+        92:23:b2:c8:ab:e5:39:93:d9:d7:ca:70:c2:ff:8f:71:40:f6:
+        c4:89:4a:72:0b:2a:7a:20:15:5b:a4:e9:75:a0:df:93:2b:7d:
+        1a:54:39:2c:80:4f:21:32:5f:9f:d8:96:08:2f:dc:e2:45:1f:
+        96:e9:31:84:90:2e:1d:07:92:56:a8:22:49:25:1b:bf:47:d5:
+        fa:34:e9:cc:7c:b2:18:ca:5e:d6:76:5e:b6:19:72:c0:10:d6:
+        c2:c6:f1:03:d4:0e:62:28:d8:56:e1:08:3a:f4:54:8f:7b:0d:
+        a5:62:53:8a:72:7b:2f:fa:80:8a:3a:54:4d:11:5c:58:7e:fc:
+        15:30:9b:fe:ef:35:a1:00:c0:15:0f:47:14:af:09:9f:1e:dd:
+        7a:ed:ea:2b:c8:a1:51:26:a3:d1:25:8c:31:1b:41:30:27:ca:
+        e8:3f:00:2b:83:8f:b4:f8:11:30:71:b8:4c:d8:af:48:88:aa:
+        e5:96:3e:f8:01:a9:17:b6:f2:09:27:d0:e9:b3:b3:89:b2:0f:
+        f7:c5:78:b3:b2:e1:26:a2:78:2b:4c:9d:99:57:4f:7e:fa:fe:
+        9b:ae:6f:c4:6a:b1:7c:d0
 -----BEGIN CERTIFICATE-----
-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
+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
-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
+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
+m65vxGqxfNA=
 -----END CERTIFICATE-----
diff --git a/sample/sample-keys/client-ec.key b/sample/sample-keys/client-ec.key
index 81313800..b0c81ffb 100644
--- a/sample/sample-keys/client-ec.key
+++ b/sample/sample-keys/client-ec.key
@@ -1,5 +1,5 @@
 -----BEGIN PRIVATE KEY-----
-MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQg2RVk/d0yok086M9bLPIi
-eu4DfcBUwphOnkje1/7VSY+hRANCAAQ7zmJdb4eCdSTCWPUOiE1XDQaycYiHWBm7
-3l9/UmJRokiRg0iRkD6HAg8VUflolxIK/dI8h4NLZVQARI0odkkF
+MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQggBG28jKEqUG3n/wcnvcr
+h2VP5dXkRChxqLw3ydT+HpGhRANCAAQlvT7axc01wETVghF3eiQSHkBTev8NDGcF
+lM5dRCZRmwxXsTgwnb0TA1kSDsg1XMq20YFBnayf7CtYBylt019c
 -----END PRIVATE KEY-----
diff --git a/sample/sample-keys/client-pass.key b/sample/sample-keys/client-pass.key
index 2bb8d4e9..089f906c 100644
--- a/sample/sample-keys/client-pass.key
+++ b/sample/sample-keys/client-pass.key
@@ -1,30 +1,30 @@
------BEGIN RSA PRIVATE KEY-----
-Proc-Type: 4,ENCRYPTED
-DEK-Info: AES-256-CBC,ECC1F209896FC2621233FFF6F1FFD045
-
-i6t7VKTyNNELTvrBO464e02nFg9rvYwumxd0sfqcPtaKmRK2mrZmEd/Xh0Nv1WyB
-PyuJo78qQixAtxObRbkSNINzTr5C8IDrE6+wQYCJinvO54U0o+ksv0tsyLngz1cb
-is8ZqHXrRgJ3qGFQWmFRtFKFQvSXOTDX3fLkEB53HfeblQCxBCnJ82Sp7ivnVR/j
-Q8qQRy1RMbzIN0trEGf0Zi4tHEvXL1u7Y+olQzSlmWWaQt20hhXUOMLhMtlRsAo7
-AwjlE94JjAfJ1q1dwIcRN4c9Lk8GkiX6w7nDpRACDpk2S8ifCqi69eGe4+g7owhL
-74bgs64PmM9a2sNXy1v6WE3c/t6sSrZiMvrGsqMo4sBlrQ9WXe0Naon7heBkPcdS
-px0YJjnyBXHMIH+ASmALSJ5JXq9vt2xRFf0dOsGapxhP+7bZJ5Pwyk/yUu5uHFbM
-/aBemlrZJzlKeYiiwpwx2whQAtDwN41zMG+r27EzSU/AaDV40NPiwwycpWt/Bp1e
-z1ag0JuS0an+PK4jmREtzT5U5BeAVM91x8YttOPpmUIpahAa1zwdYPRAIkbmPJ4z
-ZH+9YoPH4hoBQKdIhshYktjdI++xNiKXAUGUz5YoX8S68SsLdmKvhnQ7fu5VvOkA
-2pb7taXGy7zfn+a/fWauhuceV9HPlAXMIu3GsssODoNly3vpcFeiMySKppygJ3Eg
-A3o9n8UepD+jXflKG/R/t7U3hT6LqSIvQWqBqYMEVFMCNzSsJ/ce/4veFvx343zT
-qdxuzYqyiXM74cynpfqHdVa9SFICTesNdVDI0FdOXhSQ4bHJc7Xp9FFJdS0lMRw4
-ACwKxvs8lo4Gx1WFyCqH5OxosKtDHQYzdUJfSWVJlhhOFR3GncR9qSe3O5fkhJfs
-TALnC+xTJyCkSB2k0/bxVLIhlkPdCwzsrN/B6X2CDBdg0mQIo0LaPzGF8VneM20d
-XebYn751XSiL3HKyq8G5AEFwj9AO3Q8gKuP2fPoWdngJ2GT+mt1m2fIw9Igu39J0
-ZMegyUN0wSIiA5AkgryK9U+PJEiJmLzOJ/NGr7E5tPF18eZWapK4KZ8TXC4RNiye
-g+apGa+xZJz2VQp/Mrcdj9D4UDJFQjrvKaS0PXJDoYUXFBoMv3rxijzRVxlhhuJY
-yZ0At+UqZD5wpuWW6DRrgJIpy0HNhbaLmgsU0Co0HKviB0x8hvMJbi/uCoPTOdPz
-sPB7CN2i3oXe7xw1HfSTSFWb4leqjlKwNgfV42ox0QUjkkADeeuY+56g/B2+QmdE
-vXrc6sDwfNUwRUzeMn8yfum/aW1y/wrqF/qPTBQqFd85vlzS+NfXIKDg04cAljTu
-+2BLzvizh9Bb68iG4PykNXbjbAir1EbQG1tCzq1eKhERjgrxdv6+XqAmvchMCeL5
-L6hvfQFBPCo/4xnMpU5wooFarO/kGdKlGr5rXOydgfL618Td18BIX+FHQFb3zzVU
-y2NR4++DslJAZgAU+512zzpW1m3JtaRoyqyoLE2YFPlW804Xc1PBB3Ix6Wyzcegy
-D4qMk5qxjBkXEsBBSCYfVbWoMBeMhnvxkz0b9wkPtAW/jEJCB2Kkn/5yMC0DkePO
------END RSA PRIVATE KEY-----
+-----BEGIN ENCRYPTED PRIVATE KEY-----
+MIIFLTBXBgkqhkiG9w0BBQ0wSjApBgkqhkiG9w0BBQwwHAQIVDt6h9I/tNsCAggA
+MAwGCCqGSIb3DQIJBQAwHQYJYIZIAWUDBAEqBBDK/DTdm5la+nBeb36XV2oxBIIE
+0Elt0ly1Cwc1o6EHRs3rFT3EYqm9DMVrcQgquI0qdbbUMtAsDmMFmW9TI7wedCDR
+Ey3olanxK2dwz9qupSmtH25j4dFtPVxfF0moND6I4cQTmzBzTOjkK4LzgMucWfFL
++J/GQxJsh0npaEu2t7HSpbKDR4uWcRiPkjxc7gFRPJH8NF51ySnF7htUODh/lmsM
+mRbdD5asKzIvrOJSVWBs7RLtj8GRCHttOLMq6ib3O0/8WvBDPEVXfPJMH8JRNxJc
+woz6CSOPoI7yd9tKnRf0YGOuPiFWc1J1LTqgvWxVuwaUGrlwRZQ3nMnKK9jfXIGr
+FmhkHYFqWX2tpYy1nI9i7qYqG0MdWTmf/Gng1/YA5jTDW3dpcCnm5bd2eyzgw0qG
+PFnjjdVlJnEKZe5phTzrffzKWW8oOBDRww63RtgnNykipPK2V+Wq3RHQ3Oach8ZB
+0RqyLCG1wFLN9qA3TmvmPDDLsksLj9LiCstqo6FyHrvy1NFsCVlVqeVcOay1VCT9
+ApFHa5SRaW5PxTSUKfses1eIjB48Z+yplJ+6sIkv4jrTcXyjrJSmZA8GU1jVvO08
+O2W4PGLX3C4B6iIel2eZMyG2EHM24kIAH4Dqx+GDZBhSuRBwhTN7+c9nX3fmVs3t
+cTe1uPOYu73W9zHLOSIRkO8WKcyoTzf5FQqfVhVRLmb1Z0pA+qVQps6g7DyL1/da
+zwHYgdAk0wSK20JYlXOz+7lYUsg/o4sFKTYseHVQIhXyEfUIE5gBxTEltCc+FBlI
+q0wLW5axVFJZx1uaEV0/mAOLSkL8QEKd5VOlV+mT7sDk38AdyoBbk2rmmn4SeYB5
+tmAzNC1d8aTAANo51bvt9BL3gzzvAduwuzl/3kYGsd7ASnrYZYDMwxtObR3Ltj12
+Jq+Uv9lknmsbuhNWY/rXE0eQT2sT7PIW4Y3HqxzVlA3TeWc6ug7GLbabQMfeFPct
+OouOgj74jIvqBRYzLvyAdLKBuDadSVvCpxJddgS9mc3Ne53YPKtT8tPSuPzDVLRp
+rMQyHKh+C9HCEozDGAjzLbr/icE1PfmxDfKbl99C5bRG2WlSL3VNxcuRr7o09LRK
+Y2k/zE0WzQtgiNaV9MOykcf3NBgRhIYwpH+O1oT2kxlorAWJbh3FyFZUxZlPr+we
+dZSBXtrZ/6aevm76f/qsHvjqC3MfHbQ5544Z5lEvPGke2w7du7Vcu7141Oghzl0a
+qw1gCok/CKy4iWoTS8sfnaKB5eXhk9KFHN/ALHztDQlq2qQ6O2KEIndHzd3IAspB
+NgEFW+UmSankwA5QnDCoyqgvnybaCJwRcsk189PJYOUQMKrvwzdYWQJIkA/XZDGq
+3TF9+bm7hJifD4nOMI0RYU5kROPLR4nKUTkRVOaMEdV8jTCWzjPaffiYKk8IDVhy
+zVnKpuuiPBU6mZKIlBwMAEwUdFSUZ8huRCoa8UGqyukJmYR5JSxJVwtqwtCqHsXd
+2nujp0MvGdJy7V/9TIocKCbJOgubuOYt3F+tp78fUYY0P0TAVIa94Be/P5B+tzKN
+/EjT+mv6RP6YnFSKSGC8CKTolPa2rKJBH+UpaHdFdbKifmY+snIMe2wzYlI62gFj
+uJc7ZHyi4MMbzdWSLblOP+KUhn0qKBJAS12cgOVWP5bb
+-----END ENCRYPTED PRIVATE KEY-----
diff --git a/sample/sample-keys/client.crt b/sample/sample-keys/client.crt
index 1744cb22..9718d340 100644
--- a/sample/sample-keys/client.crt
+++ b/sample/sample-keys/client.crt
@@ -2,102 +2,102 @@ Certificate:
     Data:
         Version: 3 (0x2)
         Serial Number: 2 (0x2)
-    Signature Algorithm: sha256WithRSAEncryption
+        Signature Algorithm: sha256WithRSAEncryption
         Issuer: C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST/emailAddress=me@...430...
         Validity
-            Not Before: Oct 22 21:59:53 2014 GMT
-            Not After : Oct 19 21:59:53 2024 GMT
+            Not Before: Nov  7 12:23:39 2023 GMT
+            Not After : Nov  4 12:23:39 2033 GMT
         Subject: C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Client/emailAddress=me@...430...
         Subject Public Key Info:
             Public Key Algorithm: rsaEncryption
                 Public-Key: (2048 bit)
                 Modulus:
-                    00:ec:65:8f:e9:12:c2:1a:5b:e6:56:2a:08:a9:82:
-                    3a:2d:44:78:a3:00:3b:b0:9f:e7:27:10:40:93:ef:
-                    f1:cc:3e:a0:aa:04:a2:80:1b:13:a9:e6:fe:81:d6:
-                    70:90:a8:d8:d4:de:30:d8:35:00:d2:be:62:f0:48:
-                    da:fc:15:8d:c4:c6:6d:0b:99:f1:2b:83:00:0a:d3:
-                    2a:23:0b:e5:cd:f9:35:df:43:61:15:72:ad:95:98:
-                    f6:73:21:41:5e:a0:dd:47:27:a0:d5:9a:d4:41:a8:
-                    1c:1d:57:20:71:17:8f:f7:28:9e:3e:07:ce:ec:d5:
-                    0e:42:4f:1e:74:47:8e:47:9d:d2:14:28:27:2c:14:
-                    10:f5:d1:96:b5:93:74:84:ef:f9:04:de:8d:4a:6f:
-                    df:77:ab:ea:d1:58:d3:44:fe:5a:04:01:ff:06:7a:
-                    97:f7:fd:e3:57:48:e1:f0:df:40:13:9f:66:23:5a:
-                    e3:55:54:3d:54:39:ee:00:f9:12:f1:d2:df:74:2e:
-                    ba:d7:f0:8d:c6:dd:18:58:1c:93:22:0b:75:fa:a8:
-                    d6:e0:b5:2f:2d:b9:d4:fe:b9:4f:86:e2:75:48:16:
-                    60:fb:3f:c9:b4:30:42:29:fb:3b:b3:2b:b9:59:81:
-                    6a:46:f3:45:83:bf:fd:d5:1a:ff:37:0c:6f:5b:fd:
-                    61:f1
+                    00:dd:ae:b2:0a:40:e6:cf:e1:c1:a2:a1:d2:83:2c:
+                    31:98:e2:1b:b2:85:40:67:00:fa:ab:bf:cf:9d:14:
+                    d1:c6:b7:63:83:aa:5f:9c:14:a0:d2:4d:04:3a:4a:
+                    92:e6:92:4b:a4:86:40:26:42:bd:83:b7:fc:49:b7:
+                    56:d2:ca:e7:70:85:16:8f:8b:3b:da:47:9e:8b:6a:
+                    4a:c8:e6:a8:de:ae:6b:2d:52:22:0c:9d:cf:67:bb:
+                    7d:1e:66:05:53:8b:7c:ae:ad:d1:a6:52:5f:3d:9e:
+                    6b:28:18:57:d9:a1:42:2d:c0:b0:4d:da:4a:f0:29:
+                    aa:02:34:86:02:aa:af:67:09:06:ed:45:21:8e:8c:
+                    f8:75:56:c7:ea:e8:4f:88:8e:1c:8b:5b:68:2d:b1:
+                    66:a5:e4:c6:36:e2:70:8d:fe:ef:10:f0:52:f8:53:
+                    96:bf:7e:51:70:f2:3f:ae:58:87:38:d1:a3:6b:f6:
+                    38:51:9b:16:ce:67:35:8e:6d:76:63:4d:6b:9b:7d:
+                    77:da:55:6f:20:b1:66:4f:9a:2d:a4:73:3a:52:21:
+                    86:3c:f3:a6:5a:67:e5:7d:10:f5:36:56:21:7e:03:
+                    22:bd:98:e9:18:b4:3f:b3:b5:0d:ed:d5:ef:54:96:
+                    6f:9d:46:6c:6f:0e:ba:4b:1a:f7:cc:d4:e5:24:ba:
+                    d2:a5
                 Exponent: 65537 (0x10001)
         X509v3 extensions:
             X509v3 Basic Constraints: 
                 CA:FALSE
             X509v3 Subject Key Identifier: 
-                D2:B4:36:0F:B1:FC:DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D
+                59:33:B9:2E:63:D1:17:A8:9F:BD:D8:CE:94:21:C5:41:C7:31:62:5D
             X509v3 Authority Key Identifier: 
-                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E
                 DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
-                serial:A1:4E:DE:FA:90:F2:AE:81
-
+                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
     Signature Algorithm: sha256WithRSAEncryption
-         7f:e0:fe:84:a7:ec:df:62:a5:cd:3c:c1:e6:42:b1:31:12:f0:
-         b9:da:a7:9e:3f:bd:96:52:b6:fc:55:74:64:3e:e4:ff:7e:aa:
-         f7:3e:06:18:5f:73:85:f8:c8:e0:67:1b:4d:97:ca:05:d0:37:
-         07:33:64:9b:e6:78:77:14:9a:55:bb:2a:ac:c3:7f:c9:15:08:
-         83:5c:c8:c2:61:d3:71:4c:05:0b:2b:cb:a3:87:6d:a0:32:ed:
-         b0:b3:27:97:4a:55:8d:01:2a:30:56:68:ab:f2:da:5c:10:73:
-         c9:aa:0a:9c:4b:4c:a0:5b:51:6e:0a:7e:6c:53:80:b0:00:e1:
-         1e:9a:4c:0a:37:9e:20:89:bc:c5:e5:79:58:b7:45:ff:d3:c4:
-         a1:fd:d9:78:3d:45:16:74:df:82:44:1d:1d:81:50:5a:b9:32:
-         4c:e2:4f:3f:0e:3a:65:5a:64:83:3b:29:31:c4:99:88:bc:c5:
-         84:39:f2:19:12:e1:66:d0:ea:fb:75:b1:d2:27:be:91:59:a3:
-         2b:09:d5:5c:bf:46:8e:d6:67:d6:0b:ec:da:ab:f0:80:19:87:
-         64:07:a9:77:b1:5e:0c:e2:c5:1d:6a:ac:5d:23:f3:30:75:36:
-         4e:ca:c3:4e:b0:4d:8c:2c:ce:52:61:63:de:d5:f5:ef:ef:0a:
-         6b:23:25:26:3c:3a:f2:c3:c2:16:19:3f:a9:32:ba:68:f9:c9:
-         12:3c:3e:c6:1f:ff:9b:4e:f4:90:b0:63:f5:d1:33:00:30:5a:
-         e8:24:fa:35:44:9b:6a:80:f3:a6:cc:7b:3c:73:5f:50:c4:30:
-         71:d8:74:90:27:0a:01:4e:a5:5e:b1:f8:da:c2:61:81:11:ae:
-         29:a3:8f:fa:7e:4c:4e:62:b1:00:de:92:e3:8f:6a:2e:da:d9:
-         38:5d:6b:7c:0d:e4:01:aa:c8:c6:6d:8b:cd:c0:c8:6e:e4:57:
-         21:8a:f6:46:30:d9:ad:51:a1:87:96:a6:53:c9:1e:c6:bb:c3:
-         eb:55:fe:8c:d6:5c:d5:c6:f3:ca:b0:60:d2:d4:2a:1f:88:94:
-         d3:4c:1a:da:0c:94:fe:c1:5d:0d:2a:db:99:29:5d:f6:dd:16:
-         c4:c8:4d:74:9e:80:d9:d0:aa:ed:7b:e3:30:e4:47:d8:f5:15:
-         c1:71:b8:c6:fd:ee:fc:9e:b2:5f:b5:b7:92:ed:ff:ca:37:f6:
-         c7:82:b4:54:13:9b:83:cd:87:8b:7e:64:f6:2e:54:3a:22:b1:
-         c5:c1:f4:a5:25:53:9a:4d:a8:0f:e7:35:4b:89:df:19:83:66:
-         64:d9:db:d1:61:2b:24:1b:1d:44:44:fb:49:30:87:b7:49:23:
-         08:02:8a:e0:25:f3:f4:43
+    Signature Value:
+        2a:9e:02:65:f4:3c:c0:37:88:f0:21:f9:fd:2e:7c:f4:8b:bb:
+        67:7d:f7:48:0c:98:f7:a1:46:4e:33:af:68:77:f4:53:03:09:
+        fd:4e:32:cb:0f:2c:f1:16:37:35:65:aa:68:79:16:a9:32:03:
+        d7:89:10:ef:ba:fd:e1:26:2c:60:7c:3b:42:60:68:47:cf:61:
+        88:00:77:e7:71:76:49:78:35:52:45:a4:31:7e:2b:e1:0a:c8:
+        ed:e1:a7:28:2f:23:a3:ce:ce:b5:99:6b:54:4d:df:d2:64:0a:
+        b7:c5:25:1e:d4:f7:a1:fd:4f:f3:12:d3:26:5f:3b:b2:93:93:
+        d1:8b:4b:4e:dc:d0:15:63:d1:77:36:75:34:76:37:59:ff:a0:
+        81:01:ec:b6:42:2f:bd:85:5d:d0:ef:ff:90:61:d6:91:b0:f5:
+        e6:94:66:7e:4c:20:06:c4:2e:0c:9b:9f:7f:89:f0:3e:8f:e5:
+        06:6c:81:75:a2:0b:c5:ac:44:f1:32:cc:57:90:a0:19:47:8c:
+        25:7a:d5:f1:61:1f:19:bf:4c:31:da:44:c1:30:91:e8:b5:cc:
+        e4:7e:20:55:0a:b9:dc:f3:5e:f5:7c:d1:0b:ee:71:c6:d6:38:
+        7e:85:7b:6c:cb:10:85:1e:6a:50:ab:c3:ae:f9:ff:96:4f:a3:
+        76:d6:fd:c0:f9:c7:9a:60:a8:8c:e5:9a:c5:a9:7b:63:11:ef:
+        7b:b9:9b:1f:63:51:a8:6d:2b:d6:f7:ef:51:bd:a8:32:9e:92:
+        aa:24:01:c9:e3:6a:c8:94:2e:d2:66:b2:c7:17:e5:06:53:9a:
+        bd:8a:19:8f:3a:51:7a:25:11:e5:e8:59:f7:1b:df:95:98:35:
+        c1:a6:74:15:6b:b1:2c:97:9b:fe:76:7e:56:20:4d:ee:07:8a:
+        b9:8b:bc:92:a9:19:81:28:91:4e:d2:9f:51:99:72:c0:12:76:
+        5b:c8:74:68:b5:9d:43:53:c1:af:39:b9:28:82:a0:0e:bb:ef:
+        21:d8:71:dd:02:af:dc:df:48:7b:39:21:7d:83:76:ea:e2:c7:
+        16:bb:d2:1a:1d:22:f6:4b:47:15:56:41:06:4d:39:1c:96:3f:
+        25:2d:83:8f:a4:a2:86:fa:0e:e9:45:9c:bf:26:40:e6:3e:9e:
+        d5:00:9f:ce:76:6f:df:cb:b2:85:b8:83:f2:ed:8b:b6:5a:68:
+        b5:c7:1b:ab:19:75:60:f3:5b:e7:5c:70:27:d9:1c:d8:24:f0:
+        2a:aa:2a:a6:98:77:d6:36:d9:02:35:a8:d3:2c:19:88:b8:0b:
+        d3:76:58:72:54:99:94:9a:ee:38:9b:8d:8e:10:48:cd:28:50:
+        31:b2:4b:d3:69:7b:91:b4
 -----BEGIN CERTIFICATE-----
-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
+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
-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
-CAKK4CXz9EM=
+DQEBAQUAA4IBDwAwggEKAoIBAQDdrrIKQObP4cGiodKDLDGY4huyhUBnAPqrv8+d
+FNHGt2ODql+cFKDSTQQ6SpLmkkukhkAmQr2Dt/xJt1bSyudwhRaPizvaR56LakrI
+5qjermstUiIMnc9nu30eZgVTi3yurdGmUl89nmsoGFfZoUItwLBN2krwKaoCNIYC
+qq9nCQbtRSGOjPh1Vsfq6E+IjhyLW2gtsWal5MY24nCN/u8Q8FL4U5a/flFw8j+u
+WIc40aNr9jhRmxbOZzWObXZjTWubfXfaVW8gsWZPmi2kczpSIYY886ZaZ+V9EPU2
+ViF+AyK9mOkYtD+ztQ3t1e9Ulm+dRmxvDrpLGvfM1OUkutKlAgMBAAGjgdMwgdAw
+CQYDVR0TBAIwADAdBgNVHQ4EFgQUWTO5LmPRF6ifvdjOlCHFQccxYl0wgaMGA1Ud
+IwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRoMGYxCzAJBgNVBAYTAktH
+MQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEVMBMGA1UECgwMT3BlblZQ
+Ti1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW6CFG9QuNNG
+bnI0WbwAM918rhLrJ0YGMA0GCSqGSIb3DQEBCwUAA4ICAQAqngJl9DzAN4jwIfn9
+Lnz0i7tnffdIDJj3oUZOM69od/RTAwn9TjLLDyzxFjc1ZapoeRapMgPXiRDvuv3h
+JixgfDtCYGhHz2GIAHfncXZJeDVSRaQxfivhCsjt4acoLyOjzs61mWtUTd/SZAq3
+xSUe1Peh/U/zEtMmXzuyk5PRi0tO3NAVY9F3NnU0djdZ/6CBAey2Qi+9hV3Q7/+Q
+YdaRsPXmlGZ+TCAGxC4Mm59/ifA+j+UGbIF1ogvFrETxMsxXkKAZR4wletXxYR8Z
+v0wx2kTBMJHotczkfiBVCrnc8171fNEL7nHG1jh+hXtsyxCFHmpQq8Ou+f+WT6N2
+1v3A+ceaYKiM5ZrFqXtjEe97uZsfY1GobSvW9+9RvagynpKqJAHJ42rIlC7SZrLH
+F+UGU5q9ihmPOlF6JRHl6Fn3G9+VmDXBpnQVa7Esl5v+dn5WIE3uB4q5i7ySqRmB
+KJFO0p9RmXLAEnZbyHRotZ1DU8GvObkogqAOu+8h2HHdAq/c30h7OSF9g3bq4scW
+u9IaHSL2S0cVVkEGTTkclj8lLYOPpKKG+g7pRZy/JkDmPp7VAJ/Odm/fy7KFuIPy
+7Yu2Wmi1xxurGXVg81vnXHAn2RzYJPAqqiqmmHfWNtkCNajTLBmIuAvTdlhyVJmU
+mu44m42OEEjNKFAxskvTaXuRtA==
 -----END CERTIFICATE-----
diff --git a/sample/sample-keys/client.key b/sample/sample-keys/client.key
index 6d31489a..4eb27687 100644
--- a/sample/sample-keys/client.key
+++ b/sample/sample-keys/client.key
@@ -1,28 +1,28 @@
 -----BEGIN PRIVATE KEY-----
-MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDsZY/pEsIaW+ZW
-KgipgjotRHijADuwn+cnEECT7/HMPqCqBKKAGxOp5v6B1nCQqNjU3jDYNQDSvmLw
-SNr8FY3Exm0LmfErgwAK0yojC+XN+TXfQ2EVcq2VmPZzIUFeoN1HJ6DVmtRBqBwd
-VyBxF4/3KJ4+B87s1Q5CTx50R45HndIUKCcsFBD10Za1k3SE7/kE3o1Kb993q+rR
-WNNE/loEAf8Gepf3/eNXSOHw30ATn2YjWuNVVD1UOe4A+RLx0t90LrrX8I3G3RhY
-HJMiC3X6qNbgtS8tudT+uU+G4nVIFmD7P8m0MEIp+zuzK7lZgWpG80WDv/3VGv83
-DG9b/WHxAgMBAAECggEBAIOdaCpUD02trOh8LqZxowJhBOl7z7/ex0uweMPk67LT
-i5AdVHwOlzwZJ8oSIknoOBEMRBWcLQEojt1JMuL2/R95emzjIKshHHzqZKNulFvB
-TIUpdnwChTKtH0mqUkLlPU3Ienty4IpNlpmfUKimfbkWHERdBJBHbtDsTABhdo3X
-9pCF/yRKqJS2Fy/Mkl3gv1y/NB1OL4Jhl7vQbf+kmgfQN2qdOVe2BOKQ8NlPUDmE
-/1XNIDaE3s6uvUaoFfwowzsCCwN2/8QrRMMKkjvV+lEVtNmQdYxj5Xj5IwS0vkK0
-6icsngW87cpZxxc1zsRWcSTloy5ohub4FgKhlolmigECgYEA+cBlxzLvaMzMlBQY
-kCac9KQMvVL+DIFHlZA5i5L/9pRVp4JJwj3GUoehFJoFhsxnKr8HZyLwBKlCmUVm
-VxnshRWiAU18emUmeAtSGawlAS3QXhikVZDdd/L20YusLT+DXV81wlKR97/r9+17
-klQOLkSdPm9wcMDOWMNHX8bUg8kCgYEA8k+hQv6+TR/+Beao2IIctFtw/EauaJiJ
-wW5ql1cpCLPMAOQUvjs0Km3zqctfBF8mUjdkcyJ4uhL9FZtfywY22EtRIXOJ/8VR
-we65mVo6RLR8YVM54sihanuFOnlyF9LIBWB+9pUfh1/Y7DSebh7W73uxhAxQhi3Y
-QwfIQIFd8OkCgYBalH4VXhLYhpaYCiXSej6ot6rrK2N6c5Tb2MAWMA1nh+r84tMP
-gMoh+pDgYPAqMI4mQbxUmqZEeoLuBe6VHpDav7rPECRaW781AJ4ZM4cEQ3Jz/inz
-4qOAMn10CF081/Ez9ykPPlU0bsYNWHNd4eB2xWnmUBKOwk7UgJatVPaUiQKBgQCI
-f18CVGpzG9CHFnaK8FCnMNOm6VIaTcNcGY0mD81nv5Dt943P054BQMsAHTY7SjZW
-HioRyZtkhonXAB2oSqnekh7zzxgv4sG5k3ct8evdBCcE1FNJc2eqikZ0uDETRoOy
-s7cRxNNr+QxDkyikM+80HOPU1PMPgwfOSrX90GJQ8QKBgEBKohGMV/sNa4t14Iau
-qO8aagoqh/68K9GFXljsl3/iCSa964HIEREtW09Qz1w3dotEgp2w8bsDa+OwWrLy
-0SY7T5jRViM3cDWRlUBLrGGiL0FiwsfqiRiji60y19erJgrgyGVIb1kIgIBRkgFM
-2MMweASzTmZcri4PA/5C0HYb
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDdrrIKQObP4cGi
+odKDLDGY4huyhUBnAPqrv8+dFNHGt2ODql+cFKDSTQQ6SpLmkkukhkAmQr2Dt/xJ
+t1bSyudwhRaPizvaR56LakrI5qjermstUiIMnc9nu30eZgVTi3yurdGmUl89nmso
+GFfZoUItwLBN2krwKaoCNIYCqq9nCQbtRSGOjPh1Vsfq6E+IjhyLW2gtsWal5MY2
+4nCN/u8Q8FL4U5a/flFw8j+uWIc40aNr9jhRmxbOZzWObXZjTWubfXfaVW8gsWZP
+mi2kczpSIYY886ZaZ+V9EPU2ViF+AyK9mOkYtD+ztQ3t1e9Ulm+dRmxvDrpLGvfM
+1OUkutKlAgMBAAECggEANwi9ron6QzWaqtNdva7lCT1o/uLR4EB/+s99rVOT2K+C
+hxdu8QK2Aj+YgxgsbA15tfiWSGldPywX9/0KEv7IgkioFy7Lxx7sn1PeCQ4qck3+
+0ZuIVHWBHhGPuFI/lEQWyg7g81eTyWpg0+1nMeI02cLyggFlhUXyrOV5N4REU2GW
+C0KBQFyVQJPrFszomK8qsHOu/gaGC1vOwgIID3cQ3iLKXkoHNmHO4hgbeSy+SfDP
+Q5C0xxKQa2RUz0nLbByuGtLYOsJmbjUMWjFXyjmwBsPCcvRmFRdnxFvlnzwGEH4M
+ZKsw+49p1iJFyuCv7KJ/ILLJmoEuryjrSmdj3esIqQKBgQDwC24VBQLNmlug8rkG
+YWaRePsWRJylDlWIeHnfmGe27p7ytxOvGe6hnPu6nfg8nXHtruZCIhGya6qbuVmL
+vGrg94ia4MSpDVUgGiElXXQ/Pl7O9/lnSlIlxcBAgd8uggxIAzCeYI6c3r7AQcmY
+jARMwYNCxJjz5nLctMe2MCs4LwKBgQDsatDXb3xr6jmflCUZa8Kx8SOgBWEZTEGz
+KEoCQWnF2fHUCy4Bwm8Imnws3iX0198TyxkVD2rP8oGwFj2SAVtI2L8Y/g5A05TA
+knfmVECvGp/MN266ZdCA8G/MKbk727TxyJs+4AseAi5p6cBULqZHsJaZE74qlcEl
+5gFQu35ZawKBgBBgRz9J2zoZmLyvMm48ANpVzZNkVOdxxeYMigv2AsVZHCDk2oPs
+mfoOkqHVmxTPjPExKGZEmr54V+hNyc0dqpD0ci5WvTPnQ/JvtektqfuSjrdB9ZLV
+YCtRhV8hPQ+YMaxMA2oankAXdh35nv44NybhYMoSTXj+NMHX13QXbytjAoGAdVKw
+3yixWzB6dinjm1Dx5rJfVos024QPWqRUzfe+UPROYUdHBpKB3YgktXNs7KuwRbdV
+dDEZdabIGyV+WpWXwnflpbZ2Rk95k3NcUw5ep0cUJBkiNxhNt58aK/xMs1rd2dsO
+x84RVkwI0oCw9FXOKOeGZOL6TVHR70fMQU86bY8CgYEAqg/1AD9lXzbR57zaR/br
+AIn0WWU2mnU7Dc4uhmQd9+JExqrplKKHrUp8eQEOW8nij6MbPYlpgkMdatvDOJqP
+WrYtwZsKXGhnalvbS3ye20HqpjYpBR7co3Q9KMaaDNoQe9HtjbT80GXpQEbJN2Iu
+ADo3hPoX0yENIbKFccMuptM=
 -----END PRIVATE KEY-----
diff --git a/sample/sample-keys/client.p12 b/sample/sample-keys/client.p12
index 8458c79770a08e832e10205ae1c43e8059cca082..67335ac975f02c61b1386b7f511b702909b146fd 100644
GIT binary patch
literal 4707
zcmai&RZtv?vPBsf26uONLI!t&1_|yYxCM6!4ud<v-Q6_|65M@)2iHJw*TBuK_v)O_
z`_a|adskQg?W)ya2(A%4009iaB><tYhRKE9VE~W-`4C(X5P}O2hTyz_A?PmuTA+Lg
zy4hdp?-JbKru(l00PFlSAYy<Oz%2ic=wNanvX_>c-ceTa06aW092gyh{D0TrQ4rz4
z6d)AiFgbt)0uaCo#GbIhXD4|8cIw~x9PJD!g90IF=W8ZHZ1u%t7@&bBk+<8s)Qzp<
zwC-pY#a`4deWvyYrNxITd)(iRp?V`&s=p=Jd%GL=dJA2ZK??|&uK1M$FS7wT{2umQ
z0zU(KvfKO+h;fr<%8sZ&sf^G$IRDZbvIgOzsBNb0u2?kaD9ELVi!Z?cKJ*L@...2757...!*Wz
z!eN?aPPDk?GEj@...2758...<7XQVI`ALz{x1+aYWczo5bUj;^r~-ck8|yvR
z7*@oFUa|bC-!ivpcXE~lw6-Uk#Vt&}TB^hOk*wwK<=eq=&s3V>qE-k83iA!q8Y6u9
z(kPj&rLAZMO0o22z>j)}9a&P-v3PZ@...2759...&C1uJDT%JVw%!{6!n1?%U3B8c}12M!d!q
z$HU+>din7NNwu0%yPj-e$2?ldyVr3j=ZN~?70sK_5k{1xC%d$&Ee5LMuyX%soJV#g
zOfqoebI3Kne(N1hnk}?be-p{IlBf8M4jM4sdxqBHYMWRtP83j8a6w!$YM%F{C&qR5
zG>W?gZsgA|wI@...2760...<f}n?bjP6oMG^-N$q@=AzcS=T5fQPFX`;l^1Ys*6hiN
zrl-v9ijuqo?v0i2lFyCCksYVF@{T02vNzaBPSVMUYATR4L*8#)Gl+;n7g!{fyiT#~
zv_h(1L6A?yq|;R}-EC9t;6>jEu9-;f7vD%DPMyn)vQ0T#7jQ1sSSkZu;z%`&<<u;h
zSCydbc4H>#!0~l|WJ0@...2761...;@Nby!y(+)qrb_~j$OQt=mykY_v4o~rLKyDeC?U0Y^xt-
z##O0K3a#J$$~1>h$3R~Oofi0Ga|x328yqtgV)l1zMJj%2;{KsrPc@...1560...`$>^ptFY|%E
z46y*QQKJ{}p*kT8r}7%U<C~{19($&-Gln(Tx~@&&by==AL9DthQ{7V#RPMyX`lekK
z*v4SiHAxeoTEJayF*qR^5;aJFe3ztJe#>TGVg4O-bD%l@(J`{lTbkdec*Ta465Z!^
zXW6CraEz(#mwJ36y`%Z0(x9lvX~!#d!0L|iLT0^u<MJMpt-b<m#aP;%4a>9);$INe
zQwse^WA$D%exPy1KJ+Y#aQ~fQ14_@...2762...+S}?VH(VmQ4Bum13k3JTpwcU!7u-C2cxE
zkLhOf>N_yHyWl9A3pSAt-f+3vF13T3qN=7%P3OOnE-4Z1rb8m)!hmUNQRh!LFFsD;
zB;GMZvWvwGAR{!4i$E{>q}vO{_t#CuvHjS5z>SQ}3lH2^6zgbcM5`j}?b#`jqNVPZ
zA3bTWlZuRqb<&rtqa-dgnUxTxB@...2411...^>881PZr<l9p)hR2rL`RpN-Ns{jrS=6NIJ*x$
zQ_kkck}1W8x#^h{4~m9B<(q-<r_hG?9WMGN7h@?lV|-@)lpnP<+$|sc`Zb7oNKmf0
z+CAXg>{{PCG}DyD-b%>Pr?H~y63m+QWwSyl+wF?nLaT=b{g5jSiYlhm_F`h1H)UsF
zA#d*pp!}Y*8tF{;kD2oV4DBs`Kv-xa$}1L6XxspAVusHU(l3yp$Q1pY)}K3<UN#@G
z<pr8Q)Q>H4<NZ3jdx)5;-}CVnjAp=7C+K}a#)Upei(UY$*Ld|(nawvgabGEXNWb3f
zyrjyW9@...2763...*znAzYC-SINg1kKJCSU0^P0C=4YPTW=(y13bPxO;x4i26y*b-I1B
z4}P5;4Vp7gXo_!`2np%`Ne9Gd80~9w)1UU76?qKVe~xyGgMK4#)z3$BUd1cM^NDhE
zcxoI|R{6F@...2764...>AF&94nOA{myl`B~+ykHAO7f0Z$H1WU?>$%$tGIOg5Em-f;I#
z3+Sz9lQ~s)z9+e(w5<}JA7%5LgEbf-F|dkvJQP2k07MlL@...1554...{?HcF}(S8@...2765...;;FjV
zE=km!vm3XiIGiD*&ce(@q}7}@yl8VbGY7mFm;+rb`x>VmMleQ{XAyCxN&%FqWqs^!
zvOjb`d`{o>L}@ATLq0VF(`lTH@...2766...;U;Zfzo<r>q~jyIRtd(ymF>LY9`3_U*r4!
zI(iOi*LR;z^_<HXkB+7YD<$w;yNBcO(?w0zd&9nV^AsEy+DQH$YPTU92@...2767...#_E
z>n08mi@...2768...}^m9GZaxNJdzMzW^7$%bT3rc#vLdn|EgTK+AJy;V;>5o$gR!`-JSWm
zWqA%BOqPE9EnbQSVUCYsj+v*FCocqmK$BOTRGgta<b_$0BL!2RsAO#v72OEMzDAxP
z7`sVl<nWj+h~v?5o)yWh@)60T;r5s7L&_CpTIo$ot!Z#VZuyUlID$W?mz}O#nE<qY
zo~|3o{fV)_2ugm<vqkI*X_OK;nuy!4ldh4iiljq2H+-w~N5_%fU|c2mUeAlwW=U}F
zWe`I=s*8P?{&^0EStqHAg?NCY8FR6G>B~KV9XU>AXrG5qs|ZhqP-ADC@...2769...`cK
zE#q$k!T|$ez{A&TX-h6wXQY(61Ezk`>g?{z=5WGISa=y~?Hn>g8ZX*ieOMc+fCk@~
zY!S;Ww%hlpb%bRCB}^-#o&<F!mgT&UrdgOG%DD%j-?$$6hcPJntdp^J+$Cf?Q=AO<
z`FgR3g6#aUI(uI_rMWZ8<L^73qzSyKi#?2+hIDay$nM0~yT(yJg*Kop(M7Q6jX<1;
z9^|dL)r<?A&tYW}ZziiWo!oMQ^PX;#MaJjnX?QQF(Fp<;<rk6(Zl*<*VA#8tIK9@...2770...
zhZ^ZHvzY-=&#sF0n<r58E{+s_eXdBsp6|jJiTq+APU0?NMmEtLR)C7h_h71Bc1>DA
z+J*_nnwO~WJnw&HEaVecm^R&F>y}sB?mX0Gf8%`xI}H2yhG~<bY#QkCgLnr`sW02B
z;OJ!c8I`8S2+Nw-MByUE%-S3d-e-|Sw}-u^te4Prn#T~aXz0iu1-Vzqgntk~6-f^5
zatFD)U0vzhWDs~)JA^-VGN#ez+LC!^ZKl4Tx4*jg>q=PrJqN&a(C6JX+1Q|G8ON!O
zRpXSW$GsZy<u|Awq;E4(u_*uXoI+=bmyztqaA_g-vk50M#^&gIpeMYa#JO48vW_4J
z730YW$XOOoW)?Gn7<{27<XjzYq?adXt9@...2771...!Kk>roJA!78N%g)*^jb2EO=C6Pv0z_
zPDwiRSlUQwgWI_)=^|fw>&f;N4_>w~G*+LENk<HvAFT|b8r;WGAvjS9+$yGuh{ef7
zJt=T0k8zs9-AL5%?;f!XdBa06)W`|LWTBBzjLbbvxg3O7jGxRxTe#0&6%@7lP(Kb9
zml!SXaKY28ihG(@5W{wq_w(&-+J5sweCO-hHcXe@...2772...%M!}`hAaKl>!ks|s
z02lXMB-bQ=FyAa+ps>BcaBTiP@+KK6c4j|>>>0!F{`*H1${%!TaZ6IoP#@E*O-uUt
z1mn(YuTzj|)!2D*pX)RJZpOJ|j9uChn%p0^F1N*&qsxz|t!+Bu)(XS(lnRmviYadc
zQU|H!V}QB9l7~czWV^%FFWbGQA-a`fDxwK0!d9hSi7Ryth3b{diA{|C`iJ#)SICBR
zfdn%p<El9u?S5(&_sXZG%0RXKh=TJ~@tj^jjpuN)!Lgj6p{x*bp)It7mMvwg4t9=^
zJ)L9EfWLRr2xTf{(o^|Nrq3I6-AE-G?O)8xxHk06yff5SkMSVZXapHOzggUlJLPwe
zR)@o3z91?1<VZ&<FOF7-2JD#@Ap0gAn;AtlUoD{fu57jIsOJ@...2773...#}F@...2774...}<
z&xx9Xjv-Q_<Nyl>*`X)iRr>%=x9^#aOqvuKpJb9w8Atq+pEMs_dIAytgy<z$T+>X*
z%u4R!sII|Em`AOBkyn)v<izy2osG<5e)!F!(`=Aao6_Gl1-IMusy6!8A97ko1LcP6
zYCwB*RMI&4MDe^^beLa-IXyd(0vZbE!aznbVGn{ozE2RH6Aefl4Zyf!ZMwOaE!y1w
zU?d@>G1re++L%UmVR5}qD?56hf~<s#ZyR^?;=Gh&PI1r&mu=WuV<I+<xBJG3;>R$)
zdS1mx!>D7j>bIz(ef0xm%YGQHDsA#$2x7=T{P15OL39T~5S{<Z_J7M7g!ccef{qG+
z|7&vo72o_X0P*-ax_P-v+VMXDB*M|RW7r195SG`6;|Xy+2SR`|rI1Qbg?rOkM_{M>
zyKU*0b%7OT9A?6>saRe{N8K#=Q2l*kG}@>KXIrjPP?$x%RAEh>J4J0TUwa*}RIaeM
z27iixE~uhRfiC6nBHw0M{K8@!U>=F+!8lBGs$f6X@...2775...+WSiN+3l$BHA;AQYp
z0~n_E*|8g-)QTaD|E%sCLj+TL7u%hUN{1pZ!h9S=h+!r?GL<H66^a}5MTkc+B}yW7
znIf1fa#tO*i~YTBJ;qQFif#CF-GUYm`O+9YR~rjbvecQ|nFGe0Wbv|>>TCEiCsjxo
z)`I_YV1I5U&)rF&ZMYhY+k0zX*~RObEy{B<=ML4KRcZ^Tqun=alYQqt$t2kCOO#T9
zOx=41Y`I|32qV?GcVFF_F}Y38YDWlWlUu~j&aj6;&fK!r$?y3ys(-`?V2>G0{x11I
zWmVCzoR=VFt2E(-ea?t1<p@...2776...`qKDN|PIBt~<xOXwB5Byl<R88W<#T<aD^>Y7s6Z
zg!#|V;G>RRr;zjMQA@...2777...<VP_8b2&?2&b&UTB34tsbk;7&$^<ZmdFciA%+BV7dg{P)J
zj4Ns<Xht*Yxvx7lsLUEgQ_vw-@...2778...{xC6YWIQC(+IE#wQSy);pwNZlg<Q1^ZWKF
z@}Z<wml<OIF_wj;R+xQf;+UOonX&g=M4l>HqO^bXPDF|B9DVWSD(b37Ixu)O9ysPJ
zZ&z*i^JS;fG&v_)1^cXwI-{^?ORG^^92#DymR5jhG`bwV#OXmQb~!SV@...2779...
zi`Gg22HVnA_mHuyJ^RcyPF<pO_uwEtEwY5O5-){%er-NTXn)aF(>PNvI1!nd)@#xb
zaf!2=J04EciGe?U(MisVxDFWwgBmj4qL;pSwnB~doa7?LwB9mimJltM@;EIJ)Eb)i
z!g;hTCh5_rjcUGD<y&6i<K#Oxz2(D2fHIX#RLFTp10pe=c0h<R`Y}Nic}V)0U$g#p
zji{cYcuy9|3c-U-Hx1x${YeBTjeX|^athtmm?JT%$?{y7y{`U1i*~4^9rRmSbCu}j
zE5|2Pl+xk>O@`d~Fl@...2339...+%bL%;2!uKt=7JPCOU?Y)B)R(6?B!A=zVZ16Yj^7<#7&)Q
zs3Fxf+67;_o@...2780...%#bs*cpPxAvt>!1CEO+(4eXq2S*hAf`En82BAeE<(}?%p0f27w
zwS&pIp^OS$F(r-`#3o?U=&y-d<h~(^Y-VFBI~gEV>>Ab<HdQ>MkNAKc3qTVQ@)?S=
zAQ4d1&bW-StfHOiV3PBE+IIAv?D2%vale$v<6>alOAW<p(39e*5~=QwDtP$I(A`U!
zvn2VfFERGbs<1U|<OFzZ>ULsH-#ks+a5WOek1t4*III$(qvRqRyLC`xVPVh<6=8cY
zKKd5$(KrI>cp8QHM_yiPyL*lP(6OA|;db_K%a%q>A5wYIPv$2_#ZF$Ig`=Hst<-{=
zxI8pjt`gSke{!s}esffqTuwJk^Q-(?)kz-7qmVozp-M2jV~pFw%lw&*mBYF*=Yj-J
zD&&Ny)B5K^wGFILI{HdtdjC*DGSXlDIl=NFcel}y11h}2ZH<gq8{3btmFxFa)9rE4
zL54VO65X|v8C=!E%%yky`G&fVhW~@Zdrk&0-9G_~LcmD~#NTIsV8n`Vu*=$N4;3h;
z3PgmDmIq6KIl&nJyl3D6h;Tq^%SF2Q-nQ_jqY49SKRE%VhO#nqPoHFT+|ypzqxiux
R5E=D5!K7L7QNw?u_CF;_zfb@...2339...

literal 4533
zcmV;m5lZebf)TL-0Ru3C5qAa&Duzgg_YDCD0ic2rXas^0WH5peU@(FV7X}F`hDe6@
z4FLxRpn?ntFoFyO0s#Opf(!iy2`Yw2hW8Bt2LUh~1_~;MNQU<f0So~KFb)I=o?0Gd
zI2*;=0s;sCfPxFqP42^P0Fo+4$NqJRddSJSl#H$YLRhM0*>KZ1!3FrYzVTx;+~<9X
zHC&0kC=Q)Zxu{oL`xLM;b_oD>(X&8Ta-#O3&p;;Aa3+^0d5fSLOs3>{(_@...1940...
z2?mB_IU!{$1Sf&CfNA0|znHybfRqP5blsg?Z{1w#hHzm2WPm@...1941...>~Fs9L`8P!8d0*
zf18!wochm&3uJ;eC{gw3d+=?v`?TP`azbPA8uS#SvF>zu7QrQ#$t<4KatJksK>dI*
ziMISYR+%EK<vdQWAH_>GJw7P#F#ep~$fBbb6Y*_W)JH+UB%-XoF0lb%KM36b^Ml3z
zdI#>W)o{)xhylZ4OHKChQ3@...1942...{v(AQB@...1943...?ARCe`Ss=S%-q5T5+I3#R#G1YJlYRV
zDTZ`@`U38{@bSL;>xUioK!F94XIBfJNFiIhM&9nvb{1l0O6GqR&cLY4NFEuZS(DxH
z=W!uJ(?gK8gs^*{5_cl5Z(=wW&Q)XqS-~>m0O$kp(m_Cz>zwzHL-IYyDH=}xGVl+4
zq3STnMt<?Hu(MKc@...150...}O=+SOgwb9ciM@...1944...>7Am$3#DF7{7%Lk3imYa+y7?D;AsNHiG
zn<Pk<=8L8O8bLSWTRMYjAr147E?9!=!8xCjW&Rt}P1G4yKA2el8%Z#!i?O-I%bY3u
ze}EeqFzNG`%%2`feCA2|669L4WH3axOzLsnR{2`^v?3Sf>YdO(f@...1615...<&g*jh|95N+F
zs_~5PPb?@91h)&uXAR5t`>ZG>Uz4i)rF)c|;osz49745f=)!}UDtm5M!ZPf8NHf-q
zBu9VT(aN+vpUdkJ*gO8FPMV2QD1&zIpdi0sGch)W2;I$z%}w_LA6?gziR|D2-^A$7
zK+7hz{knM@...1945...{VXU4Jr29-tm$-2M^>mnD_r5Lj>iwRX!<9CFRg
z9{(YStoDvOuR@(O4i9CiwMU(U-1=C!cAqZ-t@...1946...)@bc}
zgo@...1947...=MyVE1)F@...1948...()zN_MxMHwJS(AR3ip3I+3Rm(|=OM&()I982?Ca-YME*$jcai
z5>TYla+%{gDkflN^F;$b#Qn!EsPXE?fs@...1644...=Sd<B``<<chZC5b5VFKbh2K6kY7?K3;
zv5_F`(^P~!G1NikPncT9r#;SmMJ@...1949...%Prj#Uc{m7xeQANV0K8+ojXQSMT1t*R&uV`S
z-a_ZWh-DQno_e$da>VMjI=w_}8&SK!u012g>$5F;owS>RW$?|5{~rl&$f}d%d>$9i
z7(P0*PhMARQef&fdz)sTC<Lxa5`F2&hqQLcJp#ikxf;udtXqUu6cOT-BO(BK`7h=?
zDbI?zgxg*~0$om9lkR)a-7%wHj&G~`U*39UJOt~jxs$VpQaqb)Y!11<7NJ;nxwK+f
zimu>$;%$WGWRFUiOQ+WO;A%{B*ZINIEs08%b-Fb1;6M5Z<_`ge4ELfx*V8?Qo?OBP
zB<m3&JH7$rGqlacJDUb4J^aF+$1F5Fq1BEWLf~B?AU5ccNREIEhWWFpY~t?SmGZi!
z+_Bv45Wnp@^L9d#ov%dRyPva3GUZyOBKdi&t0zyQ-jp*M&n!<8>?YAsG0gnH9<Z0S
z34D1$5L-hatRI$@6j43xOX~=Ue!pzJ_)e*2;oPP-Jt%B~H*490;ChZmyCq4v3R}?{
zc%U{&f8?Nh&k>6b5g@>h2#}&DOvoiL8%)<~q7ehzHh_`~a2Izn=bjHq;TkMIoDt-)
z$u8yg;zHv$;?HL0J6h2aH`EK>az+?|SAZS7*?6)?BsZ8yxec)dO^fx~b|xRBKv@!>
zN|H@...1594...@OZPg_<ybv-HNQS5$N@=J{hvL<!M_~BR7$uR)1P?SUJk^fttz^d1%ND_VN$$
z28yu4B=;NI-W7y*sy2dS6^$EJ{)yWxMf7wfvI_wsZ89XZlK~8n%r4)^eonEw2DGo~
zjKS~WOnU}9sPh2P#+I2oX4TWo2NAs$hrb8{T^kZeI@...1611...}Jtc8o?@wh2ORT%pAFfSL4
zF1~~3hhzo^be)F{>Xe6%y9Pyj1HI_jCpGGJ+r}qJ(Qm^(w#q#n4;fGT9J)MId6%;&
zhPes$n_zQIQ!}^}4G`^Wz7CGC@!ARFDKj^9@...1950...!~Q664CYzu=8Ev-yow*fp9UOsLHG
z-BX<D-hZ6KxIA%F5~CWcz|%QmBCt0vMQK#PYY9XsaJ3(}e;=lyMTDz8NEu@...1951...
zBTx_4BwT-RH%(I350dV3ea|XNP6YEOFyDzqfWrv_j6~`PF4!_puV5C_RkWVl#=LzN
zCn~sV+ht*A?D_2ZTy;=F_fv8<_4f`NjG$iQJ`jYg1O#mw4EYb0Mh#@$sjRlQkKJQo
zCbD(tZmv8Qv$&NNhSgU}$`rTnqcvf`wxr^&C&;Fp=5Yh`(eE{7KCj6?xingFo(wqh
zsvrza+Q>cmrr~=}pV<`ImbU@...1952...;g_=@a)XeuKL1x92`ruL2r&K(ct*Kk@...1953...
zG_=`43h3M^{O*UA{yi2s5fjtWXMOov>#rUwy(A49RjMsrwLLq>wy(A6bJnieJpm*K
zLL!(_!FKzh-$!YZdEcBK1F(>@we-M9%w^x#=H#}9Lc8NQ<BjftBjnh4ar}b3i+vXc
z{W>X2580FRsm3z}$v|1;BqjKiO00Ft{;FSiOWy|y=&D|>#PfODLKzOym9LWY;M#(=
z`T4NzCiGy4Je$gf+HwRg2c<5NBvatkd<oeEbqXy8^TV#bM^e&RCYW(w9gO&yYjX5?
z%nQKFIXw{H7UJzU>mb+(-NL)S<-&!Jq+i>}L3McC!=`WXZgNw}W3)t-k4o9(UzHmA
zq`4KU&&3!B$jn*}C9IgPAZDOKa4d3Z!m^><O=W&A+i>_uvW(Gg?u{!Zc28~KnlZY|
zW><Tb!KwKt8QoTnbcG?7D028`)ggh1eeM8r@...1954...%|k0fBmAmT5c(1mQ9lEXQ5OXd?;
z^CHjw%k!RCxFaT~aUa_d{oq#QOssTE3<rMFyeZ`^PjPynYR_KVSN@...1955...#b>Ouf
zWGfR@...1956...$;AzQkfiya1EQ_>+Bl-?jKt}^_7hPmkxyS@...1957...~^h=708E3`{=Wth%v-
z?@iOBIjVj4-#bcG%9d)#)>ITY*E8dBUmpjRV)C+>Jt32pJ`o-1#>e3Um|*mUJl)zl
zzj+A{saen+`EP}bD_BH@...1958...(cb-`Ha9p{rll@#k}4#rAwI;U5&{_(dvPfry4r*OR(g
zir1=%D70<3l-Vmdno7L-k9AWle8;LS6163q{gLq<MLcS_5kCD+V@...1959...)Z4K_T+}0D
z^did?rKv`zAu@...1960...}c$!y9^Lh|+tz8}+Z%B~F4O}J=a=6}v>ZK?WsvR6Z`rzHr@<!Tg
zr!DhMH=-r9Uq71K!AtPC3zo{oX3n#EYevQcL9~(v;6h5Pq%J*^gs-6!fq3Gog$<8b
z9g5=S4zlZ?y%K!>Mc&6F6kj#?qqpe;SHD(h=!j(z@^CR=i=KDGw>Bgokqi9zPX(uX
z|8`K|fAgElC|rkyhB5@...1961...+@}LZAfPl$+hDkByi%)V5=IaI1H{6vl7?ZBye!AqHLicO
zaCsg%BIm|>MA3R@|GjKRc3d&Xa4bb>L3UelPWRoILk&ICGoo4lwV@...1962...{{fLLaZL&+
znSPhW04KckjD)a}19>2aT|WH_ltW=y7#46Gu!-xzwtb6TmG$I_MlQkGWG4!7F2!_C
z^ngv5DN5VpziF0tnU2m8BpCW*8j$_TsVU%Wf(C_FTqJpP%DVRx*1n=yY6jVZP^~&u
zj+O<-)gVFOKz}2cqLfZKD1W%|44A(?o?C-zVkbOT+V1eU!Th4e58g?qy0IDLgSs@(
z>a3QZ_~$!6a_yYA03n@...1963...;&JCvDXIMz74j$40}k$6D5*AIe~-NPq>l=p{+`{qB*E
z)dA_uyb!%xms+1|*hgXfvXAI&FoFd^1_>&LNQU<f0S5t~f(0@...1964...(0%xf(0rtf(0f9
z3o3?4hW8Bt3<?1Ppn?SMFoFc?FdPO7Duzgg_YDCI0Ru1&1PH71K9D&o|1tss2ml0v
z1jw3_VuA6wE@...1965...*qp8m7%=>t!ahU6DY<c$m^W{&SL-}Av-!V6Mej({Vh^I65-r7>jl
zj#2E$@cqS#ot;itB65=}T$c#Fvn6>(Hu7jv5#?nqND^i{<zGDn+bGDInORh%$|<TU
z)0ArgXLA;(_k}K_mlCfE0Y&Ec4gxI|biRQj4^q@...1966...>4Z%>zfnT?a?P>WmWgPqNu
zt;=6U3*t>n)oqy#bC<px2zJip8afy*7*z$B{ma3e57nY2u4{E__iFC0=vmJwi1VYX
zJ^u9%A=Rjf0y-*9fV{WtT;tb1T0|T~;c%SH5qJ2+_GKkn#{LX}MbS`UJ+#@hq#_P@
z=VN$u@...1967...|?(z7UQ*UT5!yd!df-`=;Pg3G;+}!@XBTK@(XtDanPon_36N?ceJ<?w0
zNK3soS#I5O8%nUS5XWVt%LptQsfi0a{wtPGi{fq;)jwb;5tx!nQZ5RBwItDChWNTA
zj>Fo89J#H&5w(j6)Gb05d4Wuav-;Ae*N4CvCH7Bf7qsT7$-eiNbQFjxma-5lFy&Kf
zuGdIbq=SxP#B5y9i$6kWIXa%j=^H(Q8<<q_M*`R%ZVP8(B}EBCF@...1968...?w
z@...1969...$yFWg(e-HC0;102vJ;ImFQO7@...1970...<i79$sGU(S!1~*(w+q4OwO-ox
zWwM2kH5?dxWXufo3Q9ZIy_U`Ql+5rjkKA=C7U__H<)N5z$Rb{}rn?dsvsv@...1971...=<
zU%-OKA3|-2osy2Vwh#)*s+9to<L%b6U5k5Fzx|JW;HHBRq|s|t(&(g4xMFzgvvtbc
zQ-TBf=dLqXp>pKX1|T1Ncg_%F+OOU1K%=lJvk25edtPll^?C8iOY4l+gHVw-jwS{5
zc1H%A0AcxAK4?I%10%GT9KyndW;=S4Hs$Bt3ppdV?5;*?C+IU>_jrB|%iA@^j-Ydr
zP#Vq!z4lf1B59em!RbNV^|P^F7)gXU({v-B^T{ObdazrO(+w5OWS;WuWNRLYYIn{T
z*P_`Mm4F+5C)d0&C_P&q3l;Vwjmo9lrsR8}rTM}q1!7wAp-KZ++#udhr|@C8HVGgC
z^(J(<tv$K47<r2(#bphive7uMRA&}ky@...1972...~lV4``Zu%!1BUIf_Z=)*`CBf-+5F
zTyVg}@k=0bc9s}%M9iRHnOdEO4AU3z0GZg~26X=;y_v(F&Px}&8ufGahoEQe_>Wa-
zy{M9YD^`ZYTH01LwfQ?{ZuZQ~vaO&Jq$O&~PN%MO(9m%~EMFTMC(A&MRujojT{YuB
z`u5e(@~<aXbTu5Xpgn-u0;$_2;&dZV4?%UszI6qIM+zSz->|Ph<<tw;;-I!bhQUfx
z-T|#dTHlxbD@...1554...~1qB#O+9=PN}23-_|*ehcIXa5a)>w_vbRv_LVvmsQhWA5OYqtUvR
zb2`hE@>8knqkGmwqPuasz=MUx2NN7PM|$lkN60Vj_=3UYPS<Wb*D(aS{nk}POUoch
z5<OVHe&P<YCYq5dQgsKygF+90>r6ZIGje(Qd3rIw(m)l~LebaOD9`;d#2Rt>_%?X|
z;FA9GDiVuwAnk9Bh!BAEfMz{Mdq$b`Xzrmam}W60Fe3&DDuzgg_YDCF6)_eB6jtCP
zdB1(YHnjhMGVV2R_)j7)j4&}UAutIB1uG5%0vZJX1Qaaz-GykChO4Gdh~Eic3wrIs
TMJxme++Sbdrv3y90s;sCVF#Wx

diff --git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem
index 8eda59aa..d393581b 100644
--- a/sample/sample-keys/dh2048.pem
+++ b/sample/sample-keys/dh2048.pem
@@ -1,8 +1,8 @@
 -----BEGIN DH PARAMETERS-----
-MIIBCAKCAQEArdnA32xujHPlPI+jPffHSoMUZ+b5gRz1H1Lw9//Gugm5TAsRiYrB
-t2BDSsMKvAjyqN+i5SJv4TOk98kRRKB27iPvyXmiL945VaDQl/UehCySjYlGFUjW
-9nuo+JwQxeSbw0TLiSYoYJZQ8X1CxPl9mgJl277O4cW1Gc8I/bWa+ipU/4K5wv3h
-GI8nt+6A0jN3M/KebotMP101G4k0l0qsY4oRMTmP+z3oAP0qU9NZ1jiuMFVzRlNp
-5FdYF7ctrH+tBF+QmyT4SRKSED4wE4oX6gp420NaBhIEQifIj75wlMDtxQlpkN+x
-QkjsEbPlaPKHGQ4uupssChVUi8IM2yq5EwIBAg==
+MIIBCAKCAQEAgGOVdT2c3GUITi1pF9u+yo72PRBW7I7SnNIsHmXCRYibpyPMGxKM
+ROK6rduMllC0CjiXQZhMfqCg+GIca9xxBPKtTnwtKWD3eH5wgs24kw86mODITjJk
+6lTNM8it2HY4UuIQoFCqCdt5f5Gwgh2nwU5+dy731md6pmw9x9jUEXoyh67CeZfb
+C45x5ttzjpSBvYe5ZIiUypYKumYhdiZhk0RLefEtlUYF9oXrUExDqfYDpSO/1/X3
+oHC0O0EV3Lh1boZTG7+FjcvMYLIKYUDTmxHpII6/OAHhprg7U9ui1i7GyQRv1lze
+QV3FGO4UwLntnv352iYy91b0ls2mwD+zTwIBAg==
 -----END DH PARAMETERS-----
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 1bbc3809..fcd9166e 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -15,7 +15,8 @@ then
 fi
 
 # Generate static key for tls-auth (or static key mode)
-$(dirname ${0})/../../src/openvpn/openvpn --genkey tls-auth ta.key
+top_builddir="${top_builddir:-$(dirname ${0})/../..}"
+${top_builddir}/src/openvpn/openvpn --genkey tls-auth ta.key
 
 # Create required directories and files
 mkdir -p sample-ca
diff --git a/sample/sample-keys/server-ec.crt b/sample/sample-keys/server-ec.crt
index 7c7645a5..b66b098c 100644
--- a/sample/sample-keys/server-ec.crt
+++ b/sample/sample-keys/server-ec.crt
@@ -1,96 +1,96 @@
 Certificate:
     Data:
         Version: 3 (0x2)
-        Serial Number: 3 (0x3)
-    Signature Algorithm: sha256WithRSAEncryption
+        Serial Number: 6 (0x6)
+        Signature Algorithm: sha256WithRSAEncryption
         Issuer: C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST/emailAddress=me@...430...
         Validity
-            Not Before: Oct 22 21:59:53 2014 GMT
-            Not After : Oct 19 21:59:53 2024 GMT
+            Not Before: Nov  7 12:23:40 2023 GMT
+            Not After : Nov  4 12:23:40 2033 GMT
         Subject: C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Server-EC/emailAddress=me@...430...
         Subject Public Key Info:
             Public Key Algorithm: id-ecPublicKey
                 Public-Key: (256 bit)
                 pub:
-                    04:21:09:ac:27:e6:00:3a:57:f4:f6:c7:78:a9:b1:
-                    f4:d7:d7:45:59:39:e4:a3:d3:2c:94:f9:61:4a:e6:
-                    b9:e9:87:57:c8:0f:88:03:a0:56:ee:34:e7:e4:4e:
-                    20:63:6c:c1:6e:c1:04:ac:b9:2f:a9:76:69:d3:7d:
-                    49:ff:f1:34:cb
+                    04:d6:37:3e:63:63:00:c8:48:ad:12:01:53:e8:72:
+                    4b:b5:50:66:fc:8f:9a:a5:ea:93:cf:94:7e:9d:75:
+                    e7:9b:c5:7e:08:6f:7e:e5:b4:b6:e7:c4:f1:41:a8:
+                    49:0d:f1:e8:7c:11:40:ae:a0:f3:e0:e4:f4:8d:d4:
+                    15:47:38:55:fd
                 ASN1 OID: secp256k1
         X509v3 extensions:
-            X509v3 Basic Constraints:
+            X509v3 Basic Constraints: 
                 CA:FALSE
-            Netscape Cert Type:
+            Netscape Cert Type: 
                 SSL Server
-            Netscape Comment:
+            Netscape Comment: 
                 OpenSSL Generated Server Certificate
-            X509v3 Subject Key Identifier:
-                33:1A:42:61:9E:88:08:3F:6F:1F:98:88:3A:DD:2D:C7:07:3D:F6:9B
-            X509v3 Authority Key Identifier:
-                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
+            X509v3 Subject Key Identifier: 
+                F8:8F:75:E8:88:59:99:F2:4B:B1:0E:FC:51:52:6E:DD:2E:C9:13:90
+            X509v3 Authority Key Identifier: 
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E
                 DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
-                serial:A1:4E:DE:FA:90:F2:AE:81
-
-            X509v3 Extended Key Usage:
+                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
+            X509v3 Extended Key Usage: 
                 TLS Web Server Authentication
-            X509v3 Key Usage:
+            X509v3 Key Usage: 
                 Digital Signature, Key Encipherment
     Signature Algorithm: sha256WithRSAEncryption
-         9d:89:f6:7e:0b:43:05:22:63:e5:b3:45:a8:d9:ef:33:3c:b7:
-         19:37:28:87:27:43:43:86:a3:3f:b9:23:27:0f:96:4f:de:01:
-         80:38:6b:d9:c8:94:77:1f:06:08:34:65:77:ad:57:0c:23:99:
-         f1:51:12:5f:32:d8:9c:7c:93:f1:f6:72:2a:05:61:ff:62:aa:
-         33:aa:ef:a3:4d:d6:93:56:40:ff:38:2e:73:1c:69:fb:71:a1:
-         fa:64:19:6a:04:1c:8b:20:a8:ee:a5:18:63:f8:84:f4:ca:84:
-         8e:b6:05:48:c6:f3:f7:81:90:4d:9e:00:cd:4a:92:83:d4:93:
-         67:05:dc:16:8b:78:fa:b1:82:48:c6:86:74:44:b1:06:7e:8a:
-         c8:64:0b:82:3a:e2:f5:56:60:ea:50:70:03:da:9f:fc:28:20:
-         6b:7d:04:e0:eb:8d:e2:f1:be:82:2f:ba:51:50:2b:6c:d2:fc:
-         11:cd:69:85:3b:9e:14:19:dd:bc:14:cf:61:b0:7a:07:cb:e8:
-         e0:fc:c3:1f:a4:cb:cf:c1:e9:62:0f:d2:53:f8:ce:06:f4:f8:
-         2f:55:13:aa:67:44:b6:b8:e8:3e:82:af:66:f5:f0:7c:fe:41:
-         e6:9d:c0:9f:78:fd:00:85:02:40:63:37:fa:00:e6:3c:a6:9f:
-         35:4f:1d:a6:f1:cb:8b:04:e0:67:98:56:d1:87:58:b6:39:f6:
-         d3:fe:a8:40:50:80:7f:e6:4a:36:d0:c0:a5:61:64:1d:3a:87:
-         ad:78:72:c9:3f:98:44:35:f9:cf:32:b2:18:4c:b0:72:fa:5e:
-         6c:62:1e:d4:31:0c:c8:9b:74:f0:00:9e:70:c3:1e:c7:a4:9d:
-         03:a4:ac:1a:09:1f:86:23:65:51:34:50:86:68:1e:68:4d:9a:
-         4b:78:10:1c:bd:51:09:bb:fe:16:a3:c7:19:b4:05:44:a1:e6:
-         c6:23:76:d5:b8:3a:eb:a5:17:1d:2b:2e:fe:85:7c:88:4f:f1:
-         e8:34:32:e0:c5:96:87:c3:e8:c9:5f:89:24:10:0e:1e:07:0b:
-         2c:f8:d0:49:1b:63:5e:63:44:e9:2a:43:e2:9c:d6:f2:43:99:
-         47:f8:9b:49:1a:a7:d1:e0:53:67:1d:cb:14:b6:b0:2c:4d:b3:
-         f2:c5:62:c2:a6:09:7a:c0:6c:59:3e:73:83:0c:6c:de:30:77:
-         4d:1b:ed:b0:7f:77:87:8d:55:1d:d3:ed:f7:66:bd:06:2a:f8:
-         fd:00:e7:c0:31:e2:ff:53:9e:25:97:c6:64:84:9d:8d:61:8e:
-         c9:1f:6c:55:a1:7c:59:aa:eb:e8:2a:b2:2d:c7:09:cd:b5:3d:
-         d8:74:4f:6e:9c:3b:d5:6d
+    Signature Value:
+        72:9d:c1:ea:43:a5:fb:9f:5b:e0:35:98:c3:77:c2:84:9e:e9:
+        2c:9d:ab:6b:eb:dc:de:b2:9c:fa:38:2a:95:95:ca:35:1b:e7:
+        b4:c2:ab:72:ea:f3:8e:6e:c4:3c:98:cd:88:3d:a4:7a:92:0c:
+        83:25:e2:e0:46:c9:e8:ed:4f:35:21:0c:cd:f0:16:87:0c:cc:
+        a3:97:cf:5b:ef:1d:ce:59:78:2c:36:83:c3:59:60:79:f8:4f:
+        19:7b:19:d8:c3:03:d6:bc:33:be:c2:72:d7:0f:f8:82:de:a3:
+        e6:03:87:5e:0d:e7:9d:87:38:15:77:65:97:2d:4e:7e:d0:47:
+        99:44:f4:3a:6d:b0:f1:6d:93:2e:b4:8a:d2:38:a9:1e:00:ea:
+        68:27:2d:d8:4a:99:f0:5f:a6:f5:7d:f0:57:60:5a:f7:5d:92:
+        a4:ab:30:86:a8:5d:ac:6a:dc:4a:73:6b:5e:77:a9:b9:39:cb:
+        60:3c:b9:ff:d7:b3:81:5d:8e:6a:ef:c6:17:ea:0a:65:a3:9d:
+        1b:ff:1c:73:5c:6a:bd:9c:bf:b8:81:bc:11:2f:8b:0d:0e:80:
+        40:5c:e0:10:33:02:35:e7:8c:d8:73:38:03:b3:41:f3:45:95:
+        57:35:5c:d5:6a:3f:c6:04:79:aa:4a:1c:6d:ab:a9:35:d6:fc:
+        02:64:33:b4:d8:27:18:ff:8b:97:47:96:c9:ff:2f:93:50:26:
+        7b:3c:84:03:6d:e1:56:44:49:12:45:50:16:de:23:b5:9e:07:
+        22:2b:51:78:3c:c4:9d:64:20:7c:c3:eb:af:33:54:5f:f9:35:
+        bd:bc:91:39:cc:50:16:c2:8e:60:4e:46:9c:af:17:fb:a0:c8:
+        6f:0a:e2:50:8b:a5:a9:f4:8f:f4:fa:d4:c9:a7:73:42:0c:00:
+        6d:37:f6:3c:5d:36:8b:ef:a7:bc:d4:af:77:72:f8:c5:71:15:
+        7d:de:74:0f:ec:4c:ce:d6:4d:70:b2:64:38:cb:96:41:c2:02:
+        45:22:62:dd:9d:d2:1c:71:cd:4b:c5:92:34:8a:26:b9:b1:8f:
+        50:85:0c:40:f1:61:68:dd:af:22:1b:d3:3a:78:fc:4f:9d:c0:
+        05:ba:02:7c:15:5b:9c:4f:c8:b9:b9:14:24:fb:1c:2f:16:9f:
+        24:e6:d0:f2:a5:6b:34:c5:69:84:0a:dc:ff:90:22:c6:45:d2:
+        0b:bf:20:28:7c:52:ee:a1:00:78:e9:18:cc:11:44:06:bb:15:
+        6d:8b:39:2c:37:69:ac:2d:86:4c:ef:8c:c7:00:0a:55:c3:5a:
+        53:53:b8:46:56:3a:87:d1:93:33:20:9a:a6:75:5f:0d:23:f5:
+        40:87:e8:cf:74:b1:2a:b4
 -----BEGIN CERTIFICATE-----
-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
+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
-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
+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
-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
-Pdh0T26cO9Vt
+ZXJhdGVkIFNlcnZlciBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU+I916IhZmfJLsQ78
+UVJu3S7JE5AwgaMGA1UdIwSBmzCBmIAUc7G41oqVaxLgdHzFV1WYlFuseF6haqRo
+MGYxCzAJBgNVBAYTAktHMQswCQYDVQQIDAJOQTEQMA4GA1UEBwwHQklTSEtFSzEV
+MBMGA1UECgwMT3BlblZQTi1URVNUMSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3Qu
+bXlkb21haW6CFG9QuNNGbnI0WbwAM918rhLrJ0YGMBMGA1UdJQQMMAoGCCsGAQUF
+BwMBMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAgEAcp3B6kOl+59b4DWY
+w3fChJ7pLJ2ra+vc3rKc+jgqlZXKNRvntMKrcurzjm7EPJjNiD2kepIMgyXi4EbJ
+6O1PNSEMzfAWhwzMo5fPW+8dzll4LDaDw1lgefhPGXsZ2MMD1rwzvsJy1w/4gt6j
+5gOHXg3nnYc4FXdlly1OftBHmUT0Om2w8W2TLrSK0jipHgDqaCct2EqZ8F+m9X3w
+V2Ba912SpKswhqhdrGrcSnNrXnepuTnLYDy5/9ezgV2Oau/GF+oKZaOdG/8cc1xq
+vZy/uIG8ES+LDQ6AQFzgEDMCNeeM2HM4A7NB80WVVzVc1Wo/xgR5qkocbaupNdb8
+AmQztNgnGP+Ll0eWyf8vk1AmezyEA23hVkRJEkVQFt4jtZ4HIitReDzEnWQgfMPr
+rzNUX/k1vbyROcxQFsKOYE5GnK8X+6DIbwriUIulqfSP9PrUyadzQgwAbTf2PF02
+i++nvNSvd3L4xXEVfd50D+xMztZNcLJkOMuWQcICRSJi3Z3SHHHNS8WSNIomubGP
+UIUMQPFhaN2vIhvTOnj8T53ABboCfBVbnE/IubkUJPscLxafJObQ8qVrNMVphArc
+/5AixkXSC78gKHxS7qEAeOkYzBFEBrsVbYs5LDdprC2GTO+MxwAKVcNaU1O4RlY6
+h9GTMyCapnVfDSP1QIfoz3SxKrQ=
 -----END CERTIFICATE-----
diff --git a/sample/sample-keys/server-ec.key b/sample/sample-keys/server-ec.key
index 8f2c914e..27c8b600 100644
--- a/sample/sample-keys/server-ec.key
+++ b/sample/sample-keys/server-ec.key
@@ -1,5 +1,5 @@
 -----BEGIN PRIVATE KEY-----
-MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgLHGYqSlzoRaogmJfrC+E
-ozTothB9bORaQ1C/3FmeQ6ehRANCAAQhCawn5gA6V/T2x3ipsfTX10VZOeSj0yyU
-+WFK5rnph1fID4gDoFbuNOfkTiBjbMFuwQSsuS+pdmnTfUn/8TTL
+MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQghKHFa1jQGnTwZbFNJoJv
+RABNN9RrBuBkrXPCwOdUnt6hRANCAATWNz5jYwDISK0SAVPocku1UGb8j5ql6pPP
+lH6ddeebxX4Ib37ltLbnxPFBqEkN8eh8EUCuoPPg5PSN1BVHOFX9
 -----END PRIVATE KEY-----
diff --git a/sample/sample-keys/server.crt b/sample/sample-keys/server.crt
index 76b40448..34f696ba 100644
--- a/sample/sample-keys/server.crt
+++ b/sample/sample-keys/server.crt
@@ -2,34 +2,34 @@ Certificate:
     Data:
         Version: 3 (0x2)
         Serial Number: 1 (0x1)
-    Signature Algorithm: sha256WithRSAEncryption
+        Signature Algorithm: sha256WithRSAEncryption
         Issuer: C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST/emailAddress=me@...430...
         Validity
-            Not Before: Oct 22 21:59:52 2014 GMT
-            Not After : Oct 19 21:59:52 2024 GMT
+            Not Before: Nov  7 12:23:39 2023 GMT
+            Not After : Nov  4 12:23:39 2033 GMT
         Subject: C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Server/emailAddress=me@...430...
         Subject Public Key Info:
             Public Key Algorithm: rsaEncryption
                 Public-Key: (2048 bit)
                 Modulus:
-                    00:a5:b8:a2:ee:ce:b1:a6:0f:6a:b2:9f:d3:22:17:
-                    79:de:09:98:71:78:fa:a7:ce:36:51:54:57:c7:31:
-                    99:56:d1:8a:d6:c5:fd:52:e6:88:0e:7b:f9:ea:27:
-                    7a:bf:3f:14:ec:aa:d2:ff:8b:56:58:ac:ca:51:77:
-                    c5:3c:b6:e4:83:6f:22:06:2d:5b:eb:e7:59:d4:ab:
-                    42:c8:d5:a9:87:73:b3:73:36:51:2f:a5:d0:90:a2:
-                    87:64:54:6c:12:d3:b8:76:47:69:af:ae:8f:00:b3:
-                    70:b9:e7:67:3f:8c:6a:3d:79:5f:81:27:a3:0e:aa:
-                    a7:3d:81:48:10:b1:18:6c:38:2e:8f:7a:7b:c5:3d:
-                    21:c8:f9:a0:7f:17:2b:88:4f:ba:f2:ec:6d:24:8e:
-                    6c:f1:0a:5c:d9:5b:b1:b0:fc:49:cb:4a:d2:58:c6:
-                    2a:25:b0:97:84:c3:9e:ff:34:8c:10:46:7f:0f:fb:
-                    3c:59:7a:a6:29:0c:ae:8e:50:3a:f2:53:84:40:2d:
-                    d5:91:7b:0a:37:8e:82:77:ce:66:2f:34:77:5c:a5:
-                    45:3b:00:19:a7:07:d1:92:e6:66:b9:3b:4e:e9:63:
-                    fc:33:98:1a:ae:7b:08:7d:0a:df:7a:ba:aa:59:6d:
-                    86:82:0a:64:2b:da:59:a7:4c:4e:ef:3d:bd:04:a2:
-                    4b:31
+                    00:af:93:ce:9d:86:87:c4:8a:bb:38:6f:50:16:9b:
+                    29:70:da:5a:bd:b3:4c:5a:03:b8:e1:94:f5:3f:4b:
+                    3f:1b:05:ea:77:9e:34:59:01:99:de:81:e2:87:3a:
+                    d4:05:18:40:26:7f:a3:e9:82:52:bc:32:84:32:b9:
+                    3c:61:1f:68:5a:89:01:17:21:ec:b9:33:5b:96:33:
+                    16:91:0f:36:af:c3:0f:68:10:44:ea:e6:f9:00:35:
+                    13:61:3d:e7:a0:b1:4b:91:31:b8:11:02:a0:98:cd:
+                    fd:aa:e7:53:6c:31:05:87:36:56:c5:e4:8c:12:96:
+                    d6:f0:c4:5a:a7:0d:96:5f:f6:7a:95:ad:58:e5:6d:
+                    86:54:75:ea:da:aa:fd:1d:0c:38:19:6a:a6:24:c6:
+                    25:60:73:c4:a9:86:51:af:f6:52:45:48:f1:96:16:
+                    8e:19:ff:3f:ce:7b:d1:96:f6:2c:75:12:16:90:27:
+                    78:27:09:0a:77:a0:d8:6e:64:b0:09:94:7c:95:81:
+                    76:a7:c3:be:7d:5a:0c:5a:e4:2d:d2:15:6d:00:bb:
+                    83:a6:ac:35:dc:1e:f7:f5:67:ac:2f:70:07:fd:94:
+                    d9:b1:da:f4:8f:64:67:92:f1:f1:a8:72:27:dd:5c:
+                    d4:f1:38:ab:76:b8:4e:38:26:d4:4c:d9:87:4c:42:
+                    63:d5
                 Exponent: 65537 (0x10001)
         X509v3 extensions:
             X509v3 Basic Constraints: 
@@ -39,75 +39,75 @@ Certificate:
             Netscape Comment: 
                 OpenSSL Generated Server Certificate
             X509v3 Subject Key Identifier: 
-                B3:9D:81:E6:16:92:64:C4:86:87:F5:29:10:1B:5E:2F:74:F7:ED:B1
+                18:B9:E7:B1:3E:D2:87:C4:78:2C:0D:D9:BB:7E:BE:68:B3:FC:6A:2B
             X509v3 Authority Key Identifier: 
-                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
+                keyid:73:B1:B8:D6:8A:95:6B:12:E0:74:7C:C5:57:55:98:94:5B:AC:78:5E
                 DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@...430...
-                serial:A1:4E:DE:FA:90:F2:AE:81
-
-            X509v3 Extended Key Usage:
+                serial:6F:50:B8:D3:46:6E:72:34:59:BC:00:33:DD:7C:AE:12:EB:27:46:06
+            X509v3 Extended Key Usage: 
                 TLS Web Server Authentication
-            X509v3 Key Usage:
+            X509v3 Key Usage: 
                 Digital Signature, Key Encipherment
     Signature Algorithm: sha256WithRSAEncryption
-         4e:25:80:1b:cb:b0:42:ff:bb:3f:e8:0d:58:c1:80:db:cf:d0:
-         90:df:ca:c1:e6:41:e1:48:7f:a7:1e:c7:35:9f:9c:6d:7c:3e:
-         82:e8:de:7e:ae:82:16:00:33:0f:02:23:f1:9d:fe:2b:06:16:
-         05:55:16:89:dc:63:ac:5f:1a:31:13:79:21:a3:6e:60:28:e8:
-         e7:6b:54:00:22:a1:b7:69:5a:17:31:ce:0f:c2:a6:dd:a3:6f:
-         de:ea:19:6c:d2:d2:cb:35:9d:dd:87:51:33:68:cd:c3:9b:90:
-         55:f1:80:3d:5c:b8:09:b6:e1:3c:13:a4:5d:4a:ce:a5:11:9e:
-         f9:08:ee:be:e3:54:1d:06:4c:bb:1b:72:13:ee:7d:a0:45:cc:
-         fe:d1:3b:02:03:c1:d4:ea:45:2d:a8:c9:97:e7:f3:8a:7a:a0:
-         2f:dd:48:3a:75:c9:42:28:94:fc:af:44:52:16:68:98:d6:ad:
-         a8:65:b1:cd:ac:60:41:70:e5:44:e8:5a:f2:e7:fc:3b:fe:45:
-         89:17:1d:6d:85:c6:f0:fc:69:87:d1:1d:07:f3:cb:7b:54:8d:
-         aa:a3:cc:e3:c6:fc:d6:05:76:35:d0:26:63:8e:d1:a8:b7:ff:
-         61:42:8a:2c:63:1f:d4:ec:14:47:6b:1e:e3:81:61:12:3b:8c:
-         16:b5:cf:87:6a:2d:42:21:83:9c:0e:3a:90:3a:1e:c1:36:61:
-         41:f9:fb:4e:5d:ea:f4:df:23:92:33:2b:9b:14:9f:a0:f5:d3:
-         c4:f8:1f:2f:9c:11:36:af:2a:22:61:95:32:0b:c4:1c:2d:b1:
-         c1:0a:2a:97:c0:43:4a:6c:3e:db:00:cd:29:15:9e:7e:41:75:
-         36:a8:56:86:8c:82:9e:46:20:e5:06:1e:60:d2:03:5f:9f:9e:
-         69:bb:bf:c2:b4:43:e2:7d:85:17:83:18:41:b0:cb:a9:04:1b:
-         18:52:9f:89:8b:76:9f:94:59:81:4f:60:5b:33:18:fc:c7:52:
-         d0:d2:69:fc:0b:a2:63:32:75:43:99:e9:d7:f8:6d:c7:55:31:
-         0c:f3:ef:1a:71:e1:0a:57:e1:9d:13:b2:1e:fe:1d:ef:e4:f1:
-         51:d9:95:b3:fd:28:28:93:91:4a:29:c5:37:0e:ab:d8:85:6a:
-         fe:a8:83:1f:7b:80:5d:1f:04:79:b7:a9:08:6e:0d:d6:2e:aa:
-         7c:f6:63:7d:41:de:70:13:32:ce:dd:58:cc:a6:73:d4:72:7e:
-         d7:ac:74:a8:35:ba:c3:1b:2a:64:d7:5a:37:97:56:94:34:2b:
-         2a:71:60:bc:69:ab:00:85:b9:4f:67:32:17:51:c3:da:57:3a:
-         37:89:66:c4:7a:51:da:5f
+    Signature Value:
+        1d:e9:04:bc:77:22:d9:70:59:aa:d2:f4:4b:5b:8c:8c:6d:b8:
+        7d:0d:aa:0f:db:75:11:23:72:3a:95:34:33:63:95:16:f1:04:
+        61:95:8e:3f:36:4d:b7:28:a6:f2:ed:c8:89:8f:7f:05:65:83:
+        13:5d:42:ea:2c:1d:a8:79:25:ec:7c:19:6f:51:f2:b0:d0:19:
+        6a:db:14:ae:e4:69:91:d8:47:78:5a:d2:06:ce:fd:8f:d5:1d:
+        78:ae:86:2e:5a:f4:ef:db:05:3d:fc:12:9f:fb:76:60:60:bc:
+        2a:a0:89:50:ea:d8:1b:89:aa:5b:f5:3b:e7:af:3f:dc:ae:6e:
+        bd:5c:7e:63:52:2e:c9:6d:8f:e2:a0:fe:5d:ab:b1:dc:09:39:
+        3b:14:a0:ee:8a:a1:7d:ce:00:a2:9f:8a:b9:f2:67:71:e1:40:
+        9e:d7:c8:92:8f:a2:38:e5:8f:bc:5b:00:ab:92:2f:c5:21:83:
+        05:c7:ff:7a:84:39:99:e7:00:cb:28:2e:51:b8:e8:3e:90:84:
+        f2:d3:6a:67:b3:74:fd:e6:3f:53:b5:4a:08:6f:ed:0f:c2:81:
+        9a:eb:13:26:c1:15:1d:f3:21:51:39:56:76:55:8c:6d:79:6b:
+        5e:19:46:f2:19:2c:47:4f:2d:53:39:45:b5:50:6e:c4:1a:b6:
+        0e:9a:04:92:e9:7b:9d:d5:d7:2d:f3:30:5d:04:ce:24:93:75:
+        5c:35:51:77:e7:74:dd:97:05:bd:06:8a:a2:b2:8e:6c:74:e5:
+        9e:13:10:7e:37:b2:47:72:a0:be:b3:2f:ec:61:09:28:76:b8:
+        a1:85:28:ae:32:a7:b5:57:86:2c:d9:cd:26:f7:47:cc:92:48:
+        7d:06:ce:30:db:bc:23:fe:88:9c:75:50:7c:c0:f1:96:53:54:
+        34:b7:0c:a4:3a:66:12:ea:51:7f:ad:c7:4e:ed:98:8f:3d:c7:
+        ba:29:cd:4b:e9:e0:ce:54:a3:b0:51:d7:00:26:bb:b4:86:f6:
+        d0:76:51:9d:53:cb:52:94:e0:36:a6:9f:10:cb:79:92:4c:17:
+        cf:f2:9e:66:75:06:96:38:c1:f8:7c:22:1b:8e:53:01:bc:af:
+        86:7f:e0:02:f1:14:e2:cb:4b:94:f5:a7:c4:e3:d5:39:83:18:
+        2d:aa:ff:82:b4:da:0a:1b:5d:72:66:0d:c3:a6:7a:8a:2d:89:
+        db:e7:ea:2f:2a:ec:eb:4c:0a:2c:b1:41:1c:8d:7c:cb:78:6a:
+        a7:c5:e7:0b:7a:bf:44:de:24:02:72:da:88:77:40:5e:13:b0:
+        55:28:b5:31:1a:f9:43:79:2c:a1:fa:7d:9a:c8:7a:fe:c2:27:
+        e4:47:02:40:b6:d2:3d:35
 -----BEGIN CERTIFICATE-----
-MIIFgDCCA2igAwIBAgIBATANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
-MAkGA1UECBMCTkExEDAOBgNVBAcTB0JJU0hLRUsxFTATBgNVBAoTDE9wZW5WUE4t
-VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTE0MTAy
-MjIxNTk1MloXDTI0MTAxOTIxNTk1MlowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgT
-Ak5BMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxFDASBgNVBAMTC1Rlc3QtU2VydmVy
+MIIFizCCA3OgAwIBAgIBATANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJLRzEL
+MAkGA1UECAwCTkExEDAOBgNVBAcMB0JJU0hLRUsxFTATBgNVBAoMDE9wZW5WUE4t
+VEVTVDEhMB8GCSqGSIb3DQEJARYSbWVAbXlob3N0Lm15ZG9tYWluMB4XDTIzMTEw
+NzEyMjMzOVoXDTMzMTEwNDEyMjMzOVowajELMAkGA1UEBhMCS0cxCzAJBgNVBAgM
+Ak5BMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxFDASBgNVBAMMC1Rlc3QtU2VydmVy
 MSEwHwYJKoZIhvcNAQkBFhJtZUBteWhvc3QubXlkb21haW4wggEiMA0GCSqGSIb3
-DQEBAQUAA4IBDwAwggEKAoIBAQCluKLuzrGmD2qyn9MiF3neCZhxePqnzjZRVFfH
-MZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpRd8U8tuSDbyIGLVvr51nUq0LI
-1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C552c/jGo9eV+BJ6MOqqc9gUgQ
-sRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZW7Gw/EnLStJYxiolsJeEw57/
-NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3zmYvNHdcpUU7ABmnB9GS5ma5
-O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7vPb0EoksxAgMBAAGjggEzMIIB
-LzAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglghkgBhvhCAQ0EJhYk
-T3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBSz
-nYHmFpJkxIaH9SkQG14vdPftsTCBmAYDVR0jBIGQMIGNgBQrQOXJffX0ljjpL+Mv
-2UBkyY4Fm6FqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgTAk5BMRAwDgYDVQQH
-EwdCSVNIS0VLMRUwEwYDVQQKEwxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEW
-Em1lQG15aG9zdC5teWRvbWFpboIJAKFO3vqQ8q6BMBMGA1UdJQQMMAoGCCsGAQUF
-BwMBMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAgEATiWAG8uwQv+7P+gN
-WMGA28/QkN/KweZB4Uh/px7HNZ+cbXw+gujefq6CFgAzDwIj8Z3+KwYWBVUWidxj
-rF8aMRN5IaNuYCjo52tUACKht2laFzHOD8Km3aNv3uoZbNLSyzWd3YdRM2jNw5uQ
-VfGAPVy4CbbhPBOkXUrOpRGe+QjuvuNUHQZMuxtyE+59oEXM/tE7AgPB1OpFLajJ
-l+fzinqgL91IOnXJQiiU/K9EUhZomNatqGWxzaxgQXDlROha8uf8O/5FiRcdbYXG
-8Pxph9EdB/PLe1SNqqPM48b81gV2NdAmY47RqLf/YUKKLGMf1OwUR2se44FhEjuM
-FrXPh2otQiGDnA46kDoewTZhQfn7Tl3q9N8jkjMrmxSfoPXTxPgfL5wRNq8qImGV
-MgvEHC2xwQoql8BDSmw+2wDNKRWefkF1NqhWhoyCnkYg5QYeYNIDX5+eabu/wrRD
-4n2FF4MYQbDLqQQbGFKfiYt2n5RZgU9gWzMY/MdS0NJp/AuiYzJ1Q5np1/htx1Ux
-DPPvGnHhClfhnROyHv4d7+TxUdmVs/0oKJORSinFNw6r2IVq/qiDH3uAXR8Eebep
-CG4N1i6qfPZjfUHecBMyzt1YzKZz1HJ+16x0qDW6wxsqZNdaN5dWlDQrKnFgvGmr
-AIW5T2cyF1HD2lc6N4lmxHpR2l8=
+DQEBAQUAA4IBDwAwggEKAoIBAQCvk86dhofEirs4b1AWmylw2lq9s0xaA7jhlPU/
+Sz8bBep3njRZAZnegeKHOtQFGEAmf6PpglK8MoQyuTxhH2haiQEXIey5M1uWMxaR
+Dzavww9oEETq5vkANRNhPeegsUuRMbgRAqCYzf2q51NsMQWHNlbF5IwSltbwxFqn
+DZZf9nqVrVjlbYZUderaqv0dDDgZaqYkxiVgc8SphlGv9lJFSPGWFo4Z/z/Oe9GW
+9ix1EhaQJ3gnCQp3oNhuZLAJlHyVgXanw759Wgxa5C3SFW0Au4OmrDXcHvf1Z6wv
+cAf9lNmx2vSPZGeS8fGocifdXNTxOKt2uE44JtRM2YdMQmPVAgMBAAGjggE+MIIB
+OjAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIGQDAzBglghkgBhvhCAQ0EJhYk
+T3BlblNTTCBHZW5lcmF0ZWQgU2VydmVyIENlcnRpZmljYXRlMB0GA1UdDgQWBBQY
+ueexPtKHxHgsDdm7fr5os/xqKzCBowYDVR0jBIGbMIGYgBRzsbjWipVrEuB0fMVX
+VZiUW6x4XqFqpGgwZjELMAkGA1UEBhMCS0cxCzAJBgNVBAgMAk5BMRAwDgYDVQQH
+DAdCSVNIS0VLMRUwEwYDVQQKDAxPcGVuVlBOLVRFU1QxITAfBgkqhkiG9w0BCQEW
+Em1lQG15aG9zdC5teWRvbWFpboIUb1C400ZucjRZvAAz3XyuEusnRgYwEwYDVR0l
+BAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMA0GCSqGSIb3DQEBCwUAA4ICAQAd
+6QS8dyLZcFmq0vRLW4yMbbh9DaoP23URI3I6lTQzY5UW8QRhlY4/Nk23KKby7ciJ
+j38FZYMTXULqLB2oeSXsfBlvUfKw0Blq2xSu5GmR2Ed4WtIGzv2P1R14roYuWvTv
+2wU9/BKf+3ZgYLwqoIlQ6tgbiapb9Tvnrz/crm69XH5jUi7JbY/ioP5dq7HcCTk7
+FKDuiqF9zgCin4q58mdx4UCe18iSj6I45Y+8WwCrki/FIYMFx/96hDmZ5wDLKC5R
+uOg+kITy02pns3T95j9TtUoIb+0PwoGa6xMmwRUd8yFROVZ2VYxteWteGUbyGSxH
+Ty1TOUW1UG7EGrYOmgSS6Xud1dct8zBdBM4kk3VcNVF353TdlwW9Boqiso5sdOWe
+ExB+N7JHcqC+sy/sYQkodrihhSiuMqe1V4Ys2c0m90fMkkh9Bs4w27wj/oicdVB8
+wPGWU1Q0twykOmYS6lF/rcdO7ZiPPce6Kc1L6eDOVKOwUdcAJru0hvbQdlGdU8tS
+lOA2pp8Qy3mSTBfP8p5mdQaWOMH4fCIbjlMBvK+Gf+AC8RTiy0uU9afE49U5gxgt
+qv+CtNoKG11yZg3DpnqKLYnb5+ovKuzrTAossUEcjXzLeGqnxecLer9E3iQCctqI
+d0BeE7BVKLUxGvlDeSyh+n2ayHr+wifkRwJAttI9NQ==
 -----END CERTIFICATE-----
diff --git a/sample/sample-keys/server.key b/sample/sample-keys/server.key
index 011df12e..d4b770ac 100644
--- a/sample/sample-keys/server.key
+++ b/sample/sample-keys/server.key
@@ -1,28 +1,28 @@
 -----BEGIN PRIVATE KEY-----
-MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCluKLuzrGmD2qy
-n9MiF3neCZhxePqnzjZRVFfHMZlW0YrWxf1S5ogOe/nqJ3q/PxTsqtL/i1ZYrMpR
-d8U8tuSDbyIGLVvr51nUq0LI1amHc7NzNlEvpdCQoodkVGwS07h2R2mvro8As3C5
-52c/jGo9eV+BJ6MOqqc9gUgQsRhsOC6PenvFPSHI+aB/FyuIT7ry7G0kjmzxClzZ
-W7Gw/EnLStJYxiolsJeEw57/NIwQRn8P+zxZeqYpDK6OUDryU4RALdWRewo3joJ3
-zmYvNHdcpUU7ABmnB9GS5ma5O07pY/wzmBquewh9Ct96uqpZbYaCCmQr2lmnTE7v
-Pb0EoksxAgMBAAECggEAPMOMin+jR75TYxeTNObiunVOPh0b2zeTVxLT9KfND7ZZ
-cBK8pg79SEJRCnhbW5BnvbeNEkIm8PC6ZlDCM1bkRwUStq0fDUqQ95esLzOYq5/S
-5qW98viblszhU/pYfja/Zi8dI1uf96PT63Zbt0NnGQ9N42+DLDeKhtTGdchZqiQA
-LeSR0bQanY4tUUtCNYvBT8E3pzhoIsUzVwzIK53oovRpcOX3pMXVYZsmNhXdFFRy
-YkjMXpj7fGyaAJK0QsC+PsgrKuhXDzDttsG2lI/mq9+7RXB3d/pzhmBVWynVH2lw
-iQ7ONkSz7akDz/4I4WmxJep+FfQJYgK6rnLAlQqauQKBgQDammSAprnvDvNhSEp8
-W+xt7jQnFqaENbGgP0/D/OZMXc4khgexqlKFmSnBCRDmQ6JvLTWqDXC4+aqAbFQz
-zAIjiKaT+so8xvFRob+rBMJY5JLYKNa+zUUanfORUNYLFJPvFqnrWGaJ9uufdaM7
-0a5bu95PN74NXee3DBbpBv8HLwKBgQDCEk+IjNbjMT+Neq0ywUeM5rFrUKi92abe
-AgsVpjbighRV+6jA2lZFJcize+xYJ9wiOR1/TEI9PZ2OtBkqpwVdvTEHTagRLcvd
-NfGcptREDnNLoNWA22buQpztiEduutACWQsrd+JQmqbUicUdW4zw86/oCMbYCW3V
-QmYOLns7nwKBgHHUX20WZE91S4pmqFKlUzHTDdkk1ESX6Qx2q0R01j8BwawHFs6O
-0DW9EZ7w55nfsh+OPRl1sjK/3ubMgfQO0TZLm+IGf3Sya0qEnVeiPMkpDMX+TgRA
-wzEe+ou6uho+9uFSvdxMxeglaYA5M2ycvNwLsbEyZ4ZyVYxdgTiKahYFAoGAcIfP
-iD0qKQiYcj/tB94cz+3AeJqHjbYT1O1YYhBECOkmQ4kuG80+cs/q5W/45lEOiuWV
-Xgfo7Lu6jVGOujWoneci87oqtvNYH4e09oGh2WiLoBG9Wv9dWtBTUERSLzmxfXsG
-SAk2uEhEbj8IhfJc8iZLHH9iVUh6YEslBBodqL8CgYEAlAhvcqAvw5SzsfBR5Mcu
-4Nql6mXEVhHCvS4hdFCGaNF0z9A6eBORKJpdLWnqhpquDQDsghWE+Ga4QKSNFIi1
-fnAaykmZuY3ToqNOIaVlYM6HpMEz0wHQbTWfDLGcTFcElLZgMAk7VlDyiYVOco+E
-QX9lXOO1PGpLzXhlDxSe63Y=
+MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCvk86dhofEirs4
+b1AWmylw2lq9s0xaA7jhlPU/Sz8bBep3njRZAZnegeKHOtQFGEAmf6PpglK8MoQy
+uTxhH2haiQEXIey5M1uWMxaRDzavww9oEETq5vkANRNhPeegsUuRMbgRAqCYzf2q
+51NsMQWHNlbF5IwSltbwxFqnDZZf9nqVrVjlbYZUderaqv0dDDgZaqYkxiVgc8Sp
+hlGv9lJFSPGWFo4Z/z/Oe9GW9ix1EhaQJ3gnCQp3oNhuZLAJlHyVgXanw759Wgxa
+5C3SFW0Au4OmrDXcHvf1Z6wvcAf9lNmx2vSPZGeS8fGocifdXNTxOKt2uE44JtRM
+2YdMQmPVAgMBAAECggEAGe0W0rv4IFWRVRawGiZ0oBgeKL+TxAGjXewZABekYeEl
+wN647CEIZOAuYGRCGoknhTJ5NGnsvaLX/TAiclT+RnV5673ersTz/oyHWzQxPGhD
+8MyLi1mVOyqbNKi8zfBgMDh0mE5trc1SaoIYwh5wVTROQTqA/zMML3v5xuEta03u
+BMsNWMzm/fFXRvO6ydxdpFZkQJUeNvsGizrAhtFqsm8Cba9f/yEduyAdj2DpkG8A
+H8KmBQcAFstWX1hcC92V8qlf8RwA1o5TN82Nu2dwa+xkCTsOFK8uVE8lBkjB3C0O
+H4fGlwJ4BLUZPxIYaefn38LIQr8hZ9ITstmM2+EFoQKBgQDGD1CTdbAfGv9vBSle
+cinxflcgXOpr6XdGWZZz5VPvdE91fMgnwHOnGVZI0pI5xxO3FvrujjZ2yzTu+yme
+MG5YWjMraqdWZ0speJK7/nxIPNK+frCvVzY2sA/STgUEni2XnNkiC7w0VXWnT/xP
+rmCuJeJ211eF2bd4rrldeg9ApwKBgQDi8MiBDJFRxlP9xCTPVdTixN88Fy7JBFJE
+uZNtKeLkg2ce7bvNc9QOePXCM9Fn0NOuBTLf4SMkfFybyDKn7BTznwA0Yz2muyaK
+rzmGeGP+gzw5MQk6nzk8NIzdMYr3G9ockrMTYBNPVoiwhbshlVWNg3Qvic7cXDoB
+Q1bXfrurIwKBgQDFUDiLz3E4a+MRrWi7SKz0g1M1UJvSCfLjyRiUOWFXat5GQ5v7
+zkTpsdo+DlnS6buAaYpv4onr6yG++8VIbSNhLetQU56F+73rgM1eMHeMV9v0H67R
+3+aIsPnyH/vrz9HH+2BuBJbo5EKj/pF0qFp05BUrI/lzxaR8vES7FYDgfQKBgQDF
++zWQj7w/UPx5SKKsVr7wTrxJmhfwulpjJlqdQ4tzu8c8zj2m0UPQlGoiUD6BiUcC
+a/qkIa8c53mLVi4LHQRyPOZazbE9Qcwv9QoEbAcgRLFHW6YnhDzUbyvs1IndZmjz
+wG+Fma1+64k4JpLIi5UlbebwihLzX2ojK/IY8bEbbQKBgQC81tY7mRPAYnl5QmIQ
+YLqvQyHf/a2bVY+3XNyLF6tWngCOyt8z4Dy3pTRVI2KMVXL9+zPWuJdabwwVlWJs
+9CzR9SqYkaPP3mlbZXWt5X10OiyNU+kcCvTRNZ10OUr8XJ0tHRIuJxgBGoXdWxSF
+6uIa5Vvw9DOMFGnbugLbWuMYjQ==
 -----END PRIVATE KEY-----
diff --git a/sample/sample-keys/ta.key b/sample/sample-keys/ta.key
index 16690368..770e60d5 100644
--- a/sample/sample-keys/ta.key
+++ b/sample/sample-keys/ta.key
@@ -2,20 +2,20 @@
 # 2048 bit OpenVPN static key
 #
 -----BEGIN OpenVPN Static key V1-----
-a863b1cbdb911ff4ef3360ce135157e7
-241a465f5045f51cf9a92ebc24da34fd
-5fc48456778c977e374d55a8a7298aef
-40d0ab0c60b5e09838510526b73473a0
-8da46a8c352572dd86d4a871700a915b
-6aaa58a9dac560db2dfdd7ef15a202e1
-fca6913d7ee79c678c5798fbf7bd920c
-caa7a64720908da7254598b052d07f55
-5e31dc5721932cffbdd8965d04107415
-46c86823da18b66aab347e4522cc05ff
-634968889209c96b1024909cd4ce574c
-f829aa9c17d5df4a66043182ee23635d
-8cabf5a7ba02345ad94a3aa25a63d55c
-e13f4ad235a0825e3fe17f9419baff1c
-e73ad1dd652f1e48c7102fe8ee181e54
-10a160ae255f63fd01db1f29e6efcb8e
+21d94830510107f8753d3b6f3145e01d
+ed37075115afcb0538ecdd8503ee9663
+7218c9ed38d908d594231d7d143c73da
+5055310f89d336da99c8b3dcb18909c7
+9dd44f540670ebc0f120beb7211e9683
+9cb542572c48bfa7ffaa9a22cb8304b7
+869b92f4442918e598745bb78ac8877f
+02b00a7cdef3f2446c130d39a7c45126
+9ef399fd6029cdfc80a7c604041312ab
+0a969bc906bdee6e6d707afdcbe8c7fb
+97beb66049c3d328340775025433ceba
+1e38008a826cf92443d903106199373b
+dadd9c2c735cf481e580db4e81b99f12
+e3f46b6159c687cd1b9e689f7712573c
+0f02735a45573dfb5cd55cf464942389
+2c7e91f439bdd7337a8ceebd302cfbfa
 -----END OpenVPN Static key V1-----
-- 
2.34.1


